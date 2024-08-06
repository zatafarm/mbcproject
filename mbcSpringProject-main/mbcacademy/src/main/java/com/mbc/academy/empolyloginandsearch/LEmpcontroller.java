package com.mbc.academy.empolyloginandsearch;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.mbc.academy.emp.EmpDTO;

/**
 * Handles requests for the application home page.
 */
@Controller
public class LEmpcontroller {
	@Autowired
	private LEmplistService emps;

	// 사원 검색,조회//
	@RequestMapping(value = "/empolylist", method = RequestMethod.GET)
	public ModelAndView modalempoly(LCriteria cri) throws Exception {
		ModelAndView mv = new ModelAndView();
		LPageMaker pageMaker = new LPageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(emps.countList());
		List<LEmpDTO> list = emps.getemplist(cri);
		mv.addObject("list", list);
		mv.addObject("pageMaker", pageMaker);

		System.out.println("카운트" + emps.countList());
		mv.setViewName("modal/empolysearchmodal");
		return mv;
	}

	@RequestMapping(value = "/empolylistsearch", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView modalempolysearch(LCriteria cri, @RequestParam("searchText") String searchText,
			@RequestParam("searchSelect") String searchSelect) throws Exception {
		ModelAndView mv = new ModelAndView();
		LPageMaker pageMaker = new LPageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(emps.countsearchList(searchText, searchSelect));
		List<LEmpDTO> list = emps.getempsearch(searchText, searchSelect, cri);
		mv.addObject("list", list);
		mv.addObject("pageMaker", pageMaker);
		mv.addObject("searchSelect", searchSelect);
		mv.addObject("searchText", searchText);
		mv.setViewName("modal/empolysearchmodal2");
		return mv;
	}

	@RequestMapping(value = "/empolydetail", method = RequestMethod.GET)
	public ModelAndView modalempolydetail(@RequestParam("empno") String empno) throws Exception {
		ModelAndView mv = new ModelAndView();
		LEmpDTO dto = emps.getempdetail(empno);
		mv.addObject("emp", dto);
		System.out.println(empno);
		mv.setViewName("modal/empolydetail");
		return mv;

	}

	@RequestMapping(value = "/myprofile", method = RequestMethod.GET)
	public ModelAndView myprofile(HttpServletResponse response, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		String user = (String) session.getAttribute("id");
		ModelAndView mv = new ModelAndView();
		LEmpDTO dto = emps.getallList(user);
		System.out.println(dto.getAdr());
		mv.addObject("emp", dto);
		mv.setViewName("modal/myprofile");
		return mv;
	}

	@RequestMapping(value = "/myprofilechange", method = RequestMethod.GET)
	public ModelAndView myprofilechange(HttpServletResponse response, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		String user = (String) session.getAttribute("id");
		ModelAndView mv = new ModelAndView();
		LEmpDTO dto = emps.getallList(user);
		mv.addObject("emp", dto);
		mv.setViewName("modal/myprofilechange");
		return mv;
	}

	@RequestMapping(value = "/updateprofile", method = RequestMethod.POST)
	public void prochangeaction(@RequestParam("chemail") String chemail, @RequestParam("chadr") String chadr,
			@RequestParam("chp0") String chp0, @RequestParam("chctel") String chctel, HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		System.out.println(chemail);
		System.out.println(chp0);
		String user = (String) session.getAttribute("id");
		Map<String, Object> usercprofile = new HashMap<>();
		usercprofile.put("chemail", chemail);
		usercprofile.put("chadr", chadr);
		usercprofile.put("chp", chp0);
		usercprofile.put("chctel", chctel);
		usercprofile.put("userID", user);
		emps.updateprofile(usercprofile);
		response.setContentType("text/plain");
		response.getWriter().write("success");
	}

	@RequestMapping(value = "/myprofilepw", method = RequestMethod.POST)
	public void myprofilepw(@RequestParam("inputpw") String inputpw, HttpServletResponse response,
			HttpServletRequest request) throws IOException, Exception {
		HttpSession session = request.getSession();
		String userID = (String) session.getAttribute("id");
		LEmpDTO user = emps.getallList(userID);
		String pwcheck2 = user.getPwd();
		System.out.print(inputpw);
		if (pwcheck2 != null && pwcheck2.equals(inputpw)) {
			response.setContentType("text/plain");
			response.getWriter().write("success");
		}

	}

	@RequestMapping(value = "/changepw", method = RequestMethod.POST)
	public void changpwform(@RequestParam("cpw1") String cpw1, @RequestParam("cpw2") String cpw2,
			HttpServletResponse response, HttpServletRequest request) throws IOException, Exception {
		HttpSession session = request.getSession();
		String userID = (String) session.getAttribute("id");
		System.out.println(userID);
		LEmpDTO user = emps.getallList(userID);
		String pwcheck = user.getPwd();
		System.out.println(pwcheck);
		if (pwcheck != null && pwcheck.equals(cpw1)) {
			emps.changepw(userID, cpw2);
			response.setContentType("text/plain");
			response.getWriter().write("success");
			session.invalidate();
		} else {
			response.setContentType("text/plain");
			response.getWriter().write("failure");
		}

	}

	// 관리자
	@RequestMapping(value = "/adminempolylist", method = RequestMethod.GET)
	public ModelAndView adminempolylist(LCriteria cri) throws Exception {
		ModelAndView mv = new ModelAndView();
		LPageMaker pageMaker = new LPageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(emps.countList());
		List<LEmpDTO> list = emps.getemplist(cri);
		mv.addObject("list", list);
		mv.addObject("pageMaker", pageMaker);
		System.out.println(pageMaker.getStartPage());

		System.out.println("카운트" + emps.countList());
		mv.setViewName("empolyadmin/empolylist");
		return mv;
	}

	@RequestMapping(value = "/adminempolylistsearch", method = RequestMethod.GET)
	@ResponseBody
	public ModelAndView adminempolysearch(LCriteria cri, @RequestParam("searchText") String searchText,
			@RequestParam("searchSelect") String searchSelect) throws Exception {

		ModelAndView mv = new ModelAndView();
		LPageMaker pageMaker = new LPageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(emps.countsearchList(searchText, searchSelect));
		List<LEmpDTO> list = emps.getempsearch(searchText, searchSelect, cri);
		mv.addObject("list", list);
		mv.addObject("pageMaker", pageMaker);
		mv.addObject("searchSelect", searchSelect);
		mv.addObject("searchText", searchText);
		mv.setViewName("empolyadmin/empolylistsearch");
		return mv;

	}

	@RequestMapping(value = "/adminempolydetail", method = RequestMethod.GET)
	public ModelAndView adminempolydetail(@RequestParam("empno") String empno) throws Exception {
		ModelAndView mv = new ModelAndView();
		LEmpDTO dto = emps.getallList(empno);
		dto.Adrdivide();
		mv.addObject("emp", dto);
		mv.setViewName("empolyadmin/empolydetail");
		return mv;

	}

	@RequestMapping(value = "/aempolychange", method = RequestMethod.POST)
	public ModelAndView aempolychange(@RequestParam("empno") String empno) throws Exception {
		ModelAndView mv = new ModelAndView();
		LEmpDTO dto = emps.getallList(empno);
		dto.Adrdivide();
		mv.addObject("emp", dto);
		mv.setViewName("empolyadmin/empolydetailchange");
		return mv;

	}

	@RequestMapping(value = "/deleteempoly", method = RequestMethod.GET)
	public void deleteempoly(@RequestParam("empno") String empno, HttpServletResponse response) throws Exception {
		emps.deleteemp(empno);
		response.sendRedirect("/adminempolylist");

	}

	@PostMapping("/Updateempoly")
	public String aempolychange(@ModelAttribute("emp") EmpDTO emp, @RequestParam("adr") String adr,
			@RequestParam("photo") MultipartFile photo, HttpServletRequest request) throws Exception, IOException {
		request.setCharacterEncoding("UTF8");
		emp.setAdr(adr);
		String checkpic2 = request.getParameter("checkpic");
		// 파일을 저장할 경로 설정
		if (checkpic2.equals("1")) {
			ServletContext context = request.getSession().getServletContext();
			String uploadPath = context.getRealPath("/resources/emp_pic/");
			// 파일 이름 설정 (pic_사번.jpg)
			String fileName = "pic_" + emp.getEmpno() + ".jpg";
			// 파일을 실제로 저장하는 메서드 호출
			saveFile(photo, uploadPath, fileName);
		}
		emps.aempolychange(emp);

		return "redirect:/adminempolydetail?empno=" + emp.getEmpno();
	}

	// 사진 저장로직
	private void saveFile(MultipartFile file, String uploadPath, String fileName) throws IOException {
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdirs();
		}

		// 파일을 실제로 저장
		String filePath = uploadPath + fileName;
		File dest = new File(filePath);
		file.transferTo(dest);
	}
}
