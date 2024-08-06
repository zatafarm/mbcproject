package com.mbc.academy;

import java.io.IOException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.academy.aprv.AprvCriteria;
import com.mbc.academy.aprv.AprvDTO;
import com.mbc.academy.aprv.AprvService;
import com.mbc.academy.attd.ATTDService;
import com.mbc.academy.attd.AttdDTO;
import com.mbc.academy.board.MbcDTO;
import com.mbc.academy.board.MbcService;
import com.mbc.academy.chnemp.ChnempDTO;
import com.mbc.academy.chnemp.ChnempService;
import com.mbc.academy.empolyloginandsearch.LEmpDTO;
import com.mbc.academy.empolyloginandsearch.LEmplistService;
import com.mbc.academy.socket.WebSocketHandler;
import com.mbc.academy.socket.alarmDTO;
import com.mbc.academy.socket.alarmSerivce;


@Controller
public class MainController {
	@Autowired
	private LEmplistService emps;
	@Autowired
	private ATTDService attd;
	@Autowired
	private AprvService aprvs;
	@Autowired
	private MbcService board;
	@Autowired
	private ChnempService chnemp;
	@Autowired
	private alarmSerivce as;
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);

	private final WebSocketHandler webSocketHandler;
	
	public MainController(WebSocketHandler webSocketHandler) {
	        this.webSocketHandler = webSocketHandler;
	}
	
	//login//
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public void home(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String userok = (String) session.getAttribute("user");
     
        if (userok != null) {
            response.sendRedirect("/main");
        } else {
            response.sendRedirect("/login");
        }
    }

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String main(HttpServletRequest request, AprvCriteria cri, Model model) throws Exception {
		HttpSession session = request.getSession();
		String userok = (String) session.getAttribute("user");
		if (userok != null) {
			String sesEmpno = (String) session.getAttribute("id");
			String sesDept = (String) session.getAttribute("dept");
			Integer sesAdmns = (Integer) session.getAttribute("admns");
			cri.setSesEmpno(sesEmpno);
			cri.setSesDept(sesDept);
			cri.setSesAdmns(sesAdmns);
			List<AttdDTO> attdlist = attd.gtwlist(sesEmpno);
			List<AprvDTO> ptolist = aprvs.ptoListMain(cri);
			List<AprvDTO> aprvlist = aprvs.aprvListMain(cri);
			LEmpDTO dto = emps.getallList(sesEmpno);
			List<MbcDTO> getlist = board.getlist();
			List<MbcDTO> listrprb = board.listrprb();
			List<MbcDTO> getaumlist = board.getaumlist();
			List<ChnempDTO> chninfo = chnemp.empChnMainList();
			model.addAttribute("ptolist", ptolist);
			model.addAttribute("attdlist", attdlist);
			model.addAttribute("aprvlist", aprvlist);
			model.addAttribute("emp", dto);
			model.addAttribute("getlist", getlist);
			model.addAttribute("listrprb", listrprb);
			model.addAttribute("getaumlist", getaumlist);
			model.addAttribute("chninfo", chninfo);
			if (sesEmpno.equals("admin")) {
				return "main/adMain";
			} else {
				return "main/Main";
			}
		} else {
			return "redirect:/login";
		}
	}

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String loginForm(HttpServletRequest request) {
        // 쿠키에서 empno 및 rememberCheck 읽어오기
        String rememberCookie = null;
        String rememberCheckCookie = "false";
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("rememberCookie".equals(cookie.getName())) {
                    rememberCookie = cookie.getValue();
                }
                if ("rememberCheckCookie".equals(cookie.getName())) {
                    rememberCheckCookie = cookie.getValue();
                }
            }
        }
        request.setAttribute("rememberCookie", rememberCookie);
        request.setAttribute("rememberCheckCookie", rememberCheckCookie);
        return "login/login";
    }
    
    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        HttpSession session = request.getSession(false);
       
        if (session != null) {
            session.invalidate();
        }
        return "redirect:/"; 
    }



	
    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public String login(@RequestParam String empno, @RequestParam String pwd,
    		@RequestParam (required = false) String customCheck, RedirectAttributes rttr,
            HttpServletRequest request, HttpServletResponse response) throws IOException , Exception {
        try {
            LEmpDTO userdto = emps.getallList(empno);
            String userPwd = userdto != null ? userdto.getPwd() : null;
            if (userPwd != null && userPwd.equals(pwd)) {
                HttpSession session = request.getSession();
                session.setAttribute("user", userdto.getEname());
                session.setAttribute("id", userdto.getEmpno());
                session.setAttribute("admns", userdto.getAdmns());
                session.setAttribute("dept", userdto.getDept());
        		  LocalDate todaynow = LocalDate.now();
             if(!empno.equals("admin")) {
      		  int todayok = attd.gettoday(todaynow);
      		  if(todayok ==0) {
      			 logger.debug("실행");
      			 List<AttdDTO> attdempno = attd.getallempno();
      			 attd.allinserttoday(attdempno);
      		  }
      		 String gtw = attd.gtwselectone(empno);
      		 
      		 if (gtw == null) {
      			 attd.inserttoday(empno);
      		 }
      		 else if(gtw != null &&(gtw.equals("A0") || gtw.equals("A4"))) {
      			 attd.gtw(empno);
      		 }
      		
             }
                if ("true".equals(customCheck)) {
                	Cookie rememberCookie = new Cookie("rememberCookie", empno);
                	rememberCookie.setMaxAge(60 * 60 * 24 * 7); // 7일간 유지
                	rememberCookie.setPath("/");
                	response.addCookie(rememberCookie);
                	Cookie rememberCheckCookie = new Cookie("rememberCheckCookie", "true");
                	
                	//체크박스 상태 직전값 유지
                	rememberCheckCookie.setMaxAge(60 * 60 * 24 * 7); // 7일간 유지
                	rememberCheckCookie.setPath("/");
                	response.addCookie(rememberCheckCookie);
                } else {
                	Cookie rememberCookie = new Cookie("rememberCookie", null);
                	rememberCookie.setMaxAge(0);
                	rememberCookie.setPath("/");
                	response.addCookie(rememberCookie);
                	
                	//체크박스 상태 직전값 유지
                	Cookie rememberCheckCookie = new Cookie("rememberCheckCookie", "false");
                	rememberCheckCookie.setMaxAge(60 * 60 * 24 * 7); // 7일간 유지
                	rememberCheckCookie.setPath("/");
                	response.addCookie(rememberCheckCookie);
                }

                return "redirect:/main";
                
            } else {
                rttr.addFlashAttribute("msg", "아이디 또는 비밀번호가 올바르지 않습니다.");
                return "redirect:/login";
            }
        } catch (Exception e) {
            // 사용자 정보 조회 과정에서 예외 발생 시 처리
            e.printStackTrace(); // 에러 로그 출력
            rttr.addFlashAttribute("msg", "로그인 중 오류가 발생했습니다.");
            return "redirect:/login";
        }
    }
	//loginend//
	   @RequestMapping(value = "/ajax/resetPw", method = RequestMethod.POST)
	   public void resetPw(@RequestParam String empno, @RequestParam String email, HttpServletResponse response) throws IOException , Exception {
	      boolean exists = false;
	      try {
	         exists = emps.checkUser(empno, email);
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	      
	      response.setContentType("text/plain");
	      response.setCharacterEncoding("UTF-8");
	      response.getWriter().write(exists ? "exists" : "not exists");
	   }
	   
	    @RequestMapping(value = "/ajax/resetPw", method = RequestMethod.GET)
	    public String resetPw() {
	      logger.debug("본인인증");
	      return "modal/resetPw";
	    }
	   
	    @RequestMapping(value = "/newPwUpdate", method = RequestMethod.POST)
	   public void newPwUpdate(@RequestParam String empno, @RequestParam String newPw, HttpServletResponse response) throws IOException , Exception {
	      try {
	         boolean updated = emps.newPwUpdate(empno, newPw);
	         response.setContentType("text/plain");
	         response.setCharacterEncoding("UTF-8");
	         response.getWriter().write(updated ? "success" : "failure");
	      } catch (Exception e) {
	         e.printStackTrace();
	         response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
	         response.getWriter().write("error");
	      }
	   }
	    @RequestMapping(value = "/admintimeset", method = RequestMethod.GET)
	    public String timesetform() {
	      return "empolyadmin/timeset";
	    }
	    
	    @RequestMapping(value = "/timesetattd", method = RequestMethod.GET)
	    public String timeseting(@RequestParam("sthour") String sthour, @RequestParam("stminute") String stminute, @RequestParam("enhour") String enhour, @RequestParam("enminute") String enminute) throws Exception{
	    	String sttime = sthour + ":" + stminute;
	    	String entime = enhour + ":" + enminute;
	    	attd.settimest(sttime);
	    	attd.settimeen(entime);
 	      return "empolyadmin/timeset";
	    }
	    
	    @RequestMapping(value = "/gtw", method = RequestMethod.GET)
	    public String gtw(@RequestParam("empno") String empno,Model model,HttpServletRequest request) throws Exception{
			 String gtw = attd.gtwselectone(empno);
			 if((gtw.equals("A1") || gtw.equals("A3"))) {
				
				int a = attd.gow(empno);
				logger.debug("출근시간 기록" + a);
				if(a == 1) {
				 model.addAttribute("gowshowAlert", true); 
		        HttpSession session = request.getSession(false);
		        if (session != null) {
		            session.invalidate();
		        }
				 model.addAttribute("message", "퇴근이 완료 되었습니다.");
				    return "login/login";
				}
				 else {
					 model.addAttribute("gowshowAlert", true); 
					 model.addAttribute("message", "회사 설정 퇴근시간 전 입니다.");
					    return "main/Main";
				 }
			 }
			 else if (gtw.equals("A2")) {
				 model.addAttribute("gowshowAlert", true); 
				 model.addAttribute("message", "이미 퇴근 처리가 되었습니다.");
				 return "main/Main";
			 }
			 else if (gtw.equals("A5")) {
				 model.addAttribute("gowshowAlert", true); 
				 model.addAttribute("message", "현재 휴가 상태 입니다");
				 return "main/Main";
			 }
			 else if(gtw.equals("A4")) {
				 int a = attd.gow(empno); // 퇴근 시간 기록
				 	logger.debug("퇴근시간 기록" + a);;
				    model.addAttribute("gowshowAlert", true);
				    if (a == 1) {
				      model.addAttribute("message", "현재 휴가 상태이며, 퇴근 시간이 기록되었습니다.");
				      return "login/login";
				    } else {
				      model.addAttribute("message", "퇴근 시간 기록에 실패했습니다.");
					  return "main/Main";
				    }

			 }
	
			 else {
				 model.addAttribute("gowshowAlert", true); 
				 model.addAttribute("message", "서버 오류");
				 return "main/Main";
			 }
	
 	  
	    }
	    
	    @RequestMapping(value = "/gtwplus", method = RequestMethod.GET)
	    public String gtwplus() {
	      return "main/gtwplus";
	    }
	    
	    @RequestMapping(value = "/getalarmlist", method = RequestMethod.GET)
	    public ModelAndView getalarmlist(HttpSession session,ModelAndView mv) throws Exception {
	 			String sesEmpno = (String) session.getAttribute("id");
	    List<alarmDTO> alarmlist = as.getalarmdb(sesEmpno);
		mv.addObject("alarmlist" , alarmlist);
		mv.setViewName("include/alarmtopbar");
		return mv;
	    }
	    @RequestMapping(value = "/alarmlist", method = RequestMethod.GET)
	    public ModelAndView getalarmlist2(HttpSession session,ModelAndView mv) throws Exception {
	 			String sesEmpno = (String) session.getAttribute("id");
	    List<alarmDTO> alarmlist = as.getalarmdb(sesEmpno);
		mv.addObject("alarmlist" , alarmlist);
		mv.setViewName("main/alamlist");
		return mv;
	    }
	    
	    @RequestMapping(value = "/gtwpluslist", method = RequestMethod.GET)
	    public String gtwpluslist(HttpServletRequest request,Model model,@RequestParam("month") String month) throws Exception {
	    	   HttpSession session = request.getSession();
			String sesEmpno = (String) session.getAttribute("id");
			List<AttdDTO> attdlistmonth = attd.gtwpluslist(sesEmpno, month);
			model.addAttribute("attdlistmonth", attdlistmonth);
	      return "main/gtwplus";
	    }
	    
	    @RequestMapping(value = "/updateAlarmint", method = RequestMethod.POST)
	    @ResponseBody
	    public Map<String, String> updateAlarmint(HttpSession session, HttpServletRequest request) throws Exception {
	        String empno = (String) session.getAttribute("id");
	        String newAlarmint = Integer.toString(as.getcountalarm(empno));
	        Map<String, String> response = new HashMap<>();
	        response.put("alarmint", newAlarmint);
	        return response;
	    }
	    @RequestMapping(value = "/alarmdelete", method = RequestMethod.POST)
	    public ResponseEntity<Map<String, Object>> deletealarm(@RequestParam("alarmId") String alarmId) {
	        try {
	            as.deletealarm(alarmId);
	            
	            // 성공적으로 삭제된 경우 응답 데이터 생성
	            Map<String, Object> response = new HashMap<>();
	            response.put("message", "Alarm deleted successfully");
	            return ResponseEntity.ok(response);
	        } catch (Exception e) {
	            // 삭제 중 오류 발생 시에도 성공 응답 반환
	            Map<String, Object> response = new HashMap<>();
	            response.put("message", "Alarm deleted successfully");
	            return ResponseEntity.ok(response);
	        }
	    }

	    
}
