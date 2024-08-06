package com.mbc.academy.board;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.academy.PageMaker;
import com.mbc.academy.cmt.CmtDTO;
import com.mbc.academy.cmt.CmtService;
import com.mbc.academy.file.FileRequest;
import com.mbc.academy.file.FileResponse;
import com.mbc.academy.file.FileService;
import com.mbc.academy.file.FileUtils;

@Controller

public class MbcController {

	private static final Logger logger = LoggerFactory.getLogger(MbcController.class);

	@Autowired
	FileUtils fileutils;
	@Autowired
	MbcService service;
	@Autowired
	CmtService cmtService;
	@Autowired
	FileService fileService;

	// 사내게시판

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(MbcCriteria cri, Model model) throws Exception {

		logger.debug("===list===");

		List<MbcDTO> list = service.list(cri);
		model.addAttribute("list", list);

		int total = service.getTotalCountBoard(cri);
		PageMaker pageMaker = new PageMaker(cri, total);
		model.addAttribute("cri", cri);
		model.addAttribute("pagemaker", pageMaker);
		return "board/list";
	}

	@RequestMapping(value = "/getMbcListPage", method = RequestMethod.GET)
	public String getMbcListPage(@RequestParam(required = false) String keyword,
			@RequestParam(required = false) String searchSelect, @RequestParam int page, @RequestParam int perPageNum,
			Model model) throws Exception {

		String dcdKeyword = URLDecoder.decode(keyword, StandardCharsets.UTF_8);
		String dcdSearchSelect = URLDecoder.decode(searchSelect, StandardCharsets.UTF_8);

		MbcCriteria cri = new MbcCriteria();
		cri.setKeyword(dcdKeyword);
		cri.setSearchSelect(dcdSearchSelect);
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);

		List<MbcDTO> list = service.list(cri);
		int totalCount = service.getTotalCountBoard(cri);

		PageMaker pageMaker = new PageMaker(cri, totalCount);

		model.addAttribute("list", list);
		model.addAttribute("cri", cri);
		model.addAttribute("pageMaker", pageMaker);

		return "board/list";
	}

	@RequestMapping(value = "/mylist", method = RequestMethod.GET)
	public String mylist(MbcCriteria cri, HttpSession session, Model model) throws Exception {

		logger.debug("===list===");

		String sesEmpno = (String) session.getAttribute("id");
		logger.debug("세션등록 empno : " + sesEmpno);

		cri.setSesEmpno(sesEmpno);

		List<MbcDTO> list = service.mylist(cri);
		model.addAttribute("list", list);

		int total = service.getTotalCountMyBoard(cri);
		PageMaker pageMaker = new PageMaker(cri, total);
		model.addAttribute("pagemaker", pageMaker);
		return "board/mylist";
	}

	@RequestMapping(value = "/getMylistPage", method = RequestMethod.GET)
	public String getMylistPage(@RequestParam int page, @RequestParam int perPageNum, HttpSession session, Model model)
			throws Exception {

		String sesEmpno = (String) session.getAttribute("id");
		logger.debug("세션등록 empno : " + sesEmpno);

		MbcCriteria cri = new MbcCriteria();
		cri.setSesEmpno(sesEmpno);
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);

		List<MbcDTO> list = service.mylist(cri);
		int total = service.getTotalCountMyBoard(cri);

		PageMaker pageMaker = new PageMaker(cri, total);

		model.addAttribute("list", list);
		model.addAttribute("pageMaker", pageMaker);
		return "board/mylist";
	}

	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String detail(@RequestParam("bno") int bno, HttpSession session, Model model) throws Exception {

		// 조회수
		service.updateReadCnt(bno);

		// 현재 로그인된 사용자의 사번을 세션에서 가져오기
		String loginEmpno = (String) session.getAttribute("id");

		// 게시물 상세 정보 가져오기
		MbcDTO board = service.detail(bno);
		// 게시물의 작성자 사번
		String writeEmpno = board.getEmpno();
		// 게시물의 업로드 파일 가져오기
		List<FileResponse> fileuploaded = fileService.findAllFileByPostId(bno);
		// 현재 로그인된 사용자와 게시물의 작성자가 동일한 경우에만 수정 및 삭제 버튼을 표시
		boolean isAuthor = writeEmpno.equals(loginEmpno);

		List<CmtDTO> cmtList1 = cmtService.cmtList1(bno);
		List<CmtDTO> cnoList = cmtService.cnoList(bno);
		if (cnoList != null) {
			List<CmtDTO> cmtList2 = cmtService.cmtList2(cnoList);
			model.addAttribute("cmtList2", cmtList2);
		}
		if (fileuploaded != null) {
			String databaseContent = board.getCnt(); // 데이터베이스에서 가져온 내용
			String imgTagRegex = "<img\\s+(?:[^>]*?\\s+)?src=\"([^\"]*?)\"";
			Pattern pattern = Pattern.compile(imgTagRegex);
			Matcher matcher = pattern.matcher(databaseContent);
			if (matcher != null) {
				StringBuffer newContent = new StringBuffer();
				while (matcher.find()) {
					String originalSrc = matcher.group(1);
					logger.debug("오리지널 네임 " + originalSrc);
					FileResponse savename = fileService.findimg(bno, originalSrc);
					String savename2 = savename.getSaveName();
					String folderDate = savename.getCreatedDate().split(" ")[0].replace("-", "").substring(2);
					String newSrc = "/uploaded/" + folderDate + "/" + savename2; // 변경할 새로운 src 값
					logger.debug("바뀐경로1 " + newSrc);
					logger.debug("바뀐경로2 " + savename2);
					String newImgTag = String.format("<img src=\"%s\"", newSrc);
					logger.debug("바뀐경로3 " + newImgTag);
					matcher.appendReplacement(newContent, newImgTag);
				}
				matcher.appendTail(newContent);

				// newContent에는 src 값이 변경된 새로운 내용이 포함됨
				String updatedContent = newContent.toString();
				logger.debug(updatedContent);
				board.setCnt(updatedContent);

			}
		}
		model.addAttribute("board", board);
		model.addAttribute("isAuthor", isAuthor);
		model.addAttribute("cmtList1", cmtList1);

		return "board/detail";
	}

	@PostMapping("/detail")
	public String detail(@RequestParam("bno") int bno) throws Exception {
		// 신고수
		service.updateRprb(bno);
		return "redirect:/list";
	}

	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public String register() throws Exception {

		return "board/register";
	}

	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String register(HttpServletRequest request, HttpSession session, MbcDTO mbcDTO) throws Exception {
		request.setCharacterEncoding("utf-8");

		String loginEmpno = (String) session.getAttribute("id");
		mbcDTO.setEmpno(loginEmpno);
		int r = service.register(mbcDTO);
		int bno = mbcDTO.getBno();
		logger.debug(bno + "번 게시글 등록 시도");
		List<FileRequest> files = fileutils.uploadFiles(mbcDTO.getFiles());
		fileService.saveFiles(bno, files);
		if (r != 0) {
			logger.debug(bno + "번 게시글 등록 성공");
		} else {
			logger.debug(bno + "번 게시글 등록 실패");
		}

		return "redirect:detail?bno=" + bno + "&source=list";
	}

	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String update(@RequestParam("bno") int bno, Model model) throws Exception {
		MbcDTO board = service.detail(bno);
		List<FileResponse> fileuploaded = fileService.findAllFileByPostId(bno);
		if (fileuploaded != null) {
			String databaseContent = board.getCnt(); // 데이터베이스에서 가져온 내용
			String imgTagRegex = "<img\\s+(?:[^>]*?\\s+)?src=\"([^\"]*?)\"";
			Pattern pattern = Pattern.compile(imgTagRegex);
			Matcher matcher = pattern.matcher(databaseContent);
			if (matcher != null) {
				StringBuffer newContent = new StringBuffer();
				while (matcher.find()) {
					String originalSrc = matcher.group(1);
					logger.debug("오리지널 네임 " + originalSrc);
					FileResponse savename = fileService.findimg(bno, originalSrc);
					String savename2 = savename.getSaveName();
					String folderDate = savename.getCreatedDate().split(" ")[0].replace("-", "").substring(2);
					String newSrc = "/uploaded/" + folderDate + "/" + savename2; // 변경할 새로운 src 값
					logger.debug("바뀐경로1 " + newSrc);
					logger.debug("바뀐경로2 " + savename2);
					String newImgTag = String.format("<img src=\"%s\"", newSrc);
					logger.debug("바뀐경로3 " + newImgTag);
					matcher.appendReplacement(newContent, newImgTag);
				}
				matcher.appendTail(newContent);

				// newContent에는 src 값이 변경된 새로운 내용이 포함됨
				String updatedContent = newContent.toString();
				logger.debug(updatedContent);
				board.setCnt(updatedContent);

			}
		}
		model.addAttribute("board", board);
		return "board/update";

	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(MbcDTO mbcDTO, RedirectAttributes rttr, HttpServletRequest request) throws Exception {

		request.setCharacterEncoding("utf-8");
		int r = service.update(mbcDTO);
		// 2. 파일 업로드 (to disk)
		List<FileRequest> uploadFiles = fileutils.uploadFiles(mbcDTO.getFiles());
		logger.debug(null);
		System.out.println(uploadFiles);
		// 3. 파일 정보 저장 (to database)
		fileService.saveFiles(mbcDTO.getBno(), uploadFiles);

		// 4. 삭제할 파일 정보 조회 (from database)
		List<FileResponse> deleteFiles = fileService.findAllFileByIds(mbcDTO.getRemoveFileIds());
		System.out.println("삭제 리스트" + deleteFiles);
		// 5. 파일 삭제 (from disk)
		fileutils.deleteFiles(deleteFiles);

		// 6. 파일 삭제 (from database)
		fileService.deleteAllFileByIds(mbcDTO.getRemoveFileIds());
		if (r > 0) {
			rttr.addFlashAttribute("msg", "수정이 완료되었습니다.");
			return "redirect:detail?bno=" + mbcDTO.getBno() + "&source="
					+ (request.getParameter("source") != null ? "aumlist" : "list");
		}
		return "redirect:update?bno=" + mbcDTO.getBno();

	}

	@GetMapping("/delete")
	public String delete(@RequestParam("bno") int bno, @RequestParam(required = false) String delrea,
			RedirectAttributes rttr, HttpServletRequest request) throws Exception {
		logger.info("===delete===");
		if (delrea != null) {
			service.admnDelete(bno, delrea);
		} else {
			service.delete(bno);
		}
		rttr.addFlashAttribute("msg", "삭제되었습니다.");
		return "redirect:" + request.getParameter("source");
	}

	@PostMapping("/delete")
	@ResponseBody
	public Map<String, String> ptoDelPost(@RequestBody List<Integer> aumlist) throws Exception {
		Map<String, String> resultMap = new HashMap<>();

		try {
			for (Integer bno : aumlist) {
				service.delete(bno);
			}
			resultMap.put("msg", "삭제되었습니다.");
		} catch (Exception e) {
			resultMap.put("msg", "삭제 중 오류가 발생했습니다.");
		}

		return resultMap;
	}

	// 공지사항

	@RequestMapping(value = "/aumlist", method = RequestMethod.GET)
	public String aumlist(MbcCriteria cri, Model model) throws Exception {

		logger.debug("===list===");

		List<MbcDTO> aumlist = service.aumlist(cri);
		model.addAttribute("aumlist", aumlist);

		int total = service.getTotalAum(cri);
		PageMaker pageMaker = new PageMaker(cri, total);
		model.addAttribute("cri", cri);
		model.addAttribute("pagemaker", pageMaker);
		return "board/aumlist";
	}

	@RequestMapping(value = "/getAumListPage", method = RequestMethod.GET)
	public String modalempolyaumsearch(@RequestParam(required = false) String keyword,
			@RequestParam(required = false) String searchSelect, @RequestParam int page, @RequestParam int perPageNum,
			Model model) throws Exception {

		String dcdKeyword = URLDecoder.decode(keyword, StandardCharsets.UTF_8);
		String dcdSearchSelect = URLDecoder.decode(searchSelect, StandardCharsets.UTF_8);

		MbcCriteria cri = new MbcCriteria();
		cri.setKeyword(dcdKeyword);
		cri.setSearchSelect(dcdSearchSelect);
		cri.setPage(page);
		cri.setPerPageNum(perPageNum);

		List<MbcDTO> aumlist = service.aumlist(cri);
		int totalCount = service.getTotalAum(cri);

		PageMaker pageMaker = new PageMaker(cri, totalCount);

		model.addAttribute("cri", cri);
		model.addAttribute("aumlist", aumlist);
		model.addAttribute("pageMaker", pageMaker);
		return "board/aumlist";
	}

	@RequestMapping(value = "/aumregister", method = RequestMethod.GET)
	public String aumregister() {

		return "board/aumregister";
	}

	@RequestMapping(value = "/aumregister", method = RequestMethod.POST)
	public String aumregister(HttpServletRequest request, HttpSession session, MbcDTO mbcDTO) throws Exception {
		request.setCharacterEncoding("utf-8");

		String loginEmpno = (String) session.getAttribute("id");
		mbcDTO.setEmpno(loginEmpno);
		int r = service.register(mbcDTO);
		int bno = mbcDTO.getBno();
		logger.debug(bno + "번 게시글 등록 시도");
		List<FileRequest> files = fileutils.uploadFiles(mbcDTO.getFiles());
		fileService.saveFiles(bno, files);
		if (r != 0) {
			logger.debug(bno + "번 게시글 등록 성공");
		} else {
			logger.debug(bno + "번 게시글 등록 실패");
		}

		return "redirect:detail?bno=" + bno + "&source=aumlist";
	}

}
