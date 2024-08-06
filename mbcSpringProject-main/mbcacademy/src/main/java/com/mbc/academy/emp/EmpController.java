package com.mbc.academy.emp;

import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.academy.PageMaker;
import com.mbc.academy.chnemp.ChnempCriteria;
import com.mbc.academy.chnemp.ChnempDTO;
import com.mbc.academy.chnemp.ChnempService;
import com.mbc.academy.empolyloginandsearch.LCriteria;
import com.mbc.academy.empolyloginandsearch.LEmpDTO;
import com.mbc.academy.empolyloginandsearch.LEmplistService;
import com.mbc.academy.empolyloginandsearch.LPageMaker;

@Controller
public class EmpController {

	@Autowired
	private EmpService service;
	@Autowired
	private LEmplistService serviceL;
	@Autowired
	private ChnempService chService;

	@GetMapping("/signUp")
	public String signUp() {
		System.out.println("사원등록 창 진입 Controller");
		return "emp/signUp";
	}

	@PostMapping("/signUp")
	public String signUp(@ModelAttribute("emp") EmpDTO emp,
			@DateTimeFormat(pattern = "yyyy-MM-dd") @RequestParam("hrdt") Date hrdt,
			@DateTimeFormat(pattern = "yyyy-MM-dd") @RequestParam("bri") Date bri,
			@RequestParam("photo") MultipartFile photo, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("UTF8");
		System.out.println("사원등록 시도 Controller");

		// Date 객체를 문자열로 변환
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		String hrdtString = dateFormat.format(hrdt);
		String briString = dateFormat.format(bri);

		// 문자열로 변환된 날짜를 EmpDTO 객체에 설정
		emp.setHrdt(hrdtString);
		emp.setBri(briString);

		// 파일을 저장할 경로 설정
		ServletContext context = request.getSession().getServletContext();
		String uploadPath = context.getRealPath("/resources/emp_pic/");
		// 파일 이름 설정 (pic_사번.jpg)
		String fileName = "pic_" + emp.getEmpno() + ".jpg";
		// 파일을 실제로 저장하는 메서드 호출
		saveFile(photo, uploadPath, fileName);

		int row = service.signUp(emp);
		if (row > 0) {
			System.out.println("등록 성공 Controller");
		} else {
			System.out.println("등록 실패 Controller");
		}
		return "redirect:main";
	}

	@GetMapping("/atGnrEmpno")
	@ResponseBody
	public String atGnrEmpno(@RequestParam("year") String year) throws Exception {
		System.out.println("사번자동생성 시도 Controller - 입력된 연도: " + year);
		int atGnrEmpno = service.atGnrEmpno(year);
		// 생성된 사번을 YYYYNNN 형식으로 문자열로 변환
		String gnrEmpno = year + String.format("%03d", atGnrEmpno);
		System.out.println("사번자동생성 성공 Controller - 생성된 사번: " + gnrEmpno);
		return gnrEmpno;
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

	// 사원 검색,조회//
	@GetMapping("/emplistmodal")
	public ModelAndView modalempoly(LCriteria cri) throws Exception {
		ModelAndView mv = new ModelAndView();
		LPageMaker pageMaker = new LPageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(serviceL.countList());
		List<LEmpDTO> list = serviceL.getemplist(cri);
		mv.addObject("list", list);
		mv.addObject("pageMaker", pageMaker);

		System.out.println("카운트" + serviceL.countList());
		mv.setViewName("modal/employsearchmodal3");
		return mv;
	}

	@GetMapping("/emplistmodalsearch")
	@ResponseBody
	public ModelAndView modalempolysearch(LCriteria cri, @RequestParam("searchText") String searchText,
			@RequestParam("searchSelect") String searchSelect) throws Exception {
		ModelAndView mv = new ModelAndView();
		LPageMaker pageMaker = new LPageMaker();
		 pageMaker.setCri(cri);
		 pageMaker.setTotalCount(serviceL.countsearchList(searchText , searchSelect));
		List<LEmpDTO> list = serviceL.getempsearch(searchText , searchSelect, cri);
		mv.addObject("list" , list);
		mv.addObject("pageMaker", pageMaker);
		mv.addObject("searchSelect",searchSelect);
		mv.addObject("searchText",searchText);
		mv.setViewName("modal/employsearchmodal4");
		return mv;
	}
	
	@GetMapping("/searchEmpChn")
	@ResponseBody
	public EmpDTO searchEmpChn(@RequestParam("empno") String empno) throws Exception {
	    System.out.println("Controller: " + empno + "조회" );
	    EmpDTO emp = service.searchEmpChn(empno);
	    return emp; // JSON 형태로 반환
	}
	
	@GetMapping("/empChnList")
	public String empChnList(ChnempCriteria cri, HttpSession session, Model model) throws Exception {
		System.out.println("정보 변경 요청 리스트 조회 Controller");

		String sesEmpno = (String) session.getAttribute("id");
		System.out.println("세션등록 empno : " + sesEmpno);

		cri.setSesEmpno(sesEmpno);

		List<ChnempDTO> chninfo = chService.empChnList(cri);
		model.addAttribute("chninfo", chninfo);

		int total = chService.getTotalCountChnemp(cri);
		PageMaker pageMaker = new PageMaker(cri, total);
		model.addAttribute("pageMaker", pageMaker);
		model.addAttribute("cri", cri);

		return "emp/empChnList";
	}
	
	@GetMapping("/getEmpChnListPage")
	public String getEmpChnListPage(@RequestParam int page, @RequestParam int perPageNum,
			@RequestParam(required = false) String keyword, @RequestParam(required = false) String keyword2,
			@RequestParam(required = false) String searchField, @RequestParam String column,
			@RequestParam String sortOrder, Model model, HttpSession session) throws Exception {

		String sesEmpno = (String) session.getAttribute("id");
		System.out.println("세션등록 empno : " + sesEmpno);

		String dcdKeyword = URLDecoder.decode(keyword, StandardCharsets.UTF_8);
		String dcdKeyword2 = URLDecoder.decode(keyword2, StandardCharsets.UTF_8);
		String dcdSearchField = URLDecoder.decode(searchField, StandardCharsets.UTF_8);
		String dcdColumn = URLDecoder.decode(column, StandardCharsets.UTF_8);
		String dcdSortOrder = URLDecoder.decode(sortOrder, StandardCharsets.UTF_8);

		ChnempCriteria cri = new ChnempCriteria();
		
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);
		cri.setKeyword(dcdKeyword);
		cri.setKeyword2(dcdKeyword2);
		cri.setSearchField(dcdSearchField);
		cri.setColumn(dcdColumn);
		cri.setSortOrder(dcdSortOrder);
		cri.setSesEmpno(sesEmpno);

		List<ChnempDTO> chninfo = chService.empChnList(cri);

		int totalCount = chService.getTotalCountChnemp(cri);

		PageMaker pageMaker = new PageMaker(cri, totalCount);

		model.addAttribute("cri", cri);
		model.addAttribute("chninfo", chninfo);
		model.addAttribute("pageMaker", pageMaker);

		return "emp/empChnList";
	}
	
	@GetMapping("/empChnDetail")
	public String empChnDetail(@RequestParam("chno") int chno, Model model) throws Exception {
		System.out.println(chno + "번 변경 요청 상세 조회 Controller");
		ChnempDTO chninfo = chService.empChnDetail(chno);
		model.addAttribute("chninfo", chninfo);
		return "emp/empChnDetail";
	}
	
	@PostMapping("/confirmChn")
	public String confirmChn(ChnempDTO chninfo, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
		System.out.println(chninfo.getChno() + "번 변경 완료 Controller");
		request.setCharacterEncoding("UTF-8");

		int r = chService.confirmChn(chninfo);
		if (r > 0) {
			System.out.println(chninfo.getChno() + "번 요청 처리 성공 Controller");
			rttr.addFlashAttribute("msg", "요청이 처리되었습니다.");
		} else {
			System.out.println(chninfo.getChno() + "번 처리 실패 Controller");
		}
		return "redirect:/empChnDetail?chno=" + chninfo.getChno();
	}
	
	@GetMapping("/empChnDel")
	public String empChnDel(@RequestParam("chno") int chno, RedirectAttributes rttr) throws Exception {
		int r = chService.empChnDel(chno);
		if (r > 0) {
			rttr.addFlashAttribute("msg", "삭제 되었습니다.");
			return "redirect:/empChnList";
		}
		return "redirect:empChnDetail?chno=" + chno;
	}
	
	@PostMapping("/empChnDel")
	@ResponseBody
	public Map<String, String> empChnDelPost(@RequestBody List<Integer> empChnList) throws Exception {
		Map<String, String> resultMap = new HashMap<>();

		try {
			for (Integer chno : empChnList) {
				chService.empChnDel(chno);
			}
			resultMap.put("msg", "삭제되었습니다.");
		} catch (Exception e) {
			resultMap.put("msg", "삭제 중 오류가 발생했습니다.");
		}

		return resultMap;
	}
	
	@GetMapping("/empChnApply")
	public String empChnApplyWin() throws Exception {
		return "/emp/empChnApply";
	}
	
	@PostMapping("/empChnApply")
	public String empChnApply(ChnempDTO dto, RedirectAttributes rttr, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("UTF8");
		System.out.println("Controller 정정신청등록 시도");
		
		int row = chService.empChnApply(dto);
		if (row > 0) {
			System.out.println("Controller 정정신청등록 성공");
			rttr.addFlashAttribute("chno", dto.getChno());
		    return "redirect:empChnDetail?chno=" + dto.getChno();
		} else {
			System.out.println("Controller 정정신청등록 실패");
			return "/emp/empChnApply";
		}
	}
	
	@GetMapping("/empChnModify")
	public String empChnModify(@RequestParam("chno") int chno, Model model) throws Exception {
		ChnempDTO chninfo = chService.empChnDetail(chno);
		model.addAttribute("chninfo", chninfo);
		return "/emp/empChnModify";
	}
	
	@PostMapping("/empChnModify")
	public String empChnModify(ChnempDTO dto, HttpServletRequest request) throws Exception {
		request.setCharacterEncoding("UTF8");
		System.out.println("Controller 정정신청수정 시도");
		
		int row = chService.empChnModify(dto);
		if (row > 0) {
			System.out.println("Controller 정정신청등록 성공");
			return "redirect:empChnDetail?chno=" + dto.getChno();
		} else {
			System.out.println("Controller 정정신청등록 실패");
			return "redirect:/empChnModify?chno=" + dto.getChno();
		}
	}
}
