package com.mbc.academy.aprv;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.academy.PageMaker;
import com.mbc.academy.socket.WebSocketHandler;

@Controller
public class AprvController {

   private static final Logger logger = LoggerFactory.getLogger(AprvController.class);
   @Autowired
   private AprvService service;

   @Autowired
   private WebSocketHandler webSocketHandler;
   

   @GetMapping("/ptoList")
   public String ptoList(AprvCriteria cri, HttpSession session, Model model) throws Exception {
      logger.debug("신청 리스트 조회 Controller");

      String sesEmpno = (String) session.getAttribute("id");
      logger.debug("세션등록 empno : " + sesEmpno);

      cri.setSesEmpno(sesEmpno);

      List<AprvDTO> ptolist = service.ptoList(cri);
      model.addAttribute("ptolist", ptolist);

      int total = service.getTotalCountPto(cri);
      PageMaker pageMaker = new PageMaker(cri, total);
      model.addAttribute("pageMaker", pageMaker);
      model.addAttribute("cri", cri);

      return "aprv/ptoList";
   }

   @GetMapping("/getPtoListPage")
   public String getPtoListPage(@RequestParam int page, @RequestParam int perPageNum,
         @RequestParam(required = false) String keyword, @RequestParam(required = false) String keyword2,
         @RequestParam(required = false) String searchField, @RequestParam String column,
         @RequestParam String sortOrder, Model model, HttpSession session) throws Exception {

      String sesEmpno = (String) session.getAttribute("id");
      logger.debug("세션등록 empno : " + sesEmpno);

      String dcdKeyword = URLDecoder.decode(keyword, StandardCharsets.UTF_8);
      String dcdKeyword2 = URLDecoder.decode(keyword2, StandardCharsets.UTF_8);
      String dcdSearchField = URLDecoder.decode(searchField, StandardCharsets.UTF_8);
      String dcdColumn = URLDecoder.decode(column, StandardCharsets.UTF_8);
      String dcdSortOrder = URLDecoder.decode(sortOrder, StandardCharsets.UTF_8);

      AprvCriteria cri = new AprvCriteria();
      
      cri.setPage(page);
      cri.setPerPageNum(perPageNum);
      cri.setKeyword(dcdKeyword);
      cri.setKeyword2(dcdKeyword2);
      cri.setSearchField(dcdSearchField);
      cri.setColumn(dcdColumn);
      cri.setSortOrder(dcdSortOrder);
      cri.setSesEmpno(sesEmpno);

      List<AprvDTO> ptolist = service.ptoList(cri);

      int totalCount = service.getTotalCountPto(cri);

      PageMaker pageMaker = new PageMaker(cri, totalCount);

      model.addAttribute("cri", cri);
      model.addAttribute("ptolist", ptolist);
      model.addAttribute("pageMaker", pageMaker);

      return "aprv/ptoList";
   }

   @GetMapping("/aprvList")
   public String list(AprvCriteria cri, HttpSession session, Model model) throws Exception {
      logger.debug("결재 리스트 조회 Controller");

      Integer sesAdmns = (Integer) session.getAttribute("admns");
      String sesDept = (String) session.getAttribute("dept");

      logger.debug("세션등록 admns : " + sesAdmns + ", dept : " + sesDept);

      cri.setSesAdmns(sesAdmns);
      cri.setSesDept(sesDept);

      List<AprvDTO> list = service.aprvList(cri);
      model.addAttribute("list", list);

      int total = service.getTotalCountAprv(cri);
      PageMaker pageMaker = new PageMaker(cri, total);
      model.addAttribute("pageMaker", pageMaker);
      model.addAttribute("cri", cri);

      return "aprv/aprvList";

   }

   @GetMapping("/getAprvListPage")
   public String getAprvListPage(@RequestParam int page, @RequestParam int perPageNum,
         @RequestParam(required = false) String keyword, @RequestParam(required = false) String keyword2,
         @RequestParam(required = false) String searchField, @RequestParam String column,
         @RequestParam String sortOrder, Model model, HttpSession session) throws Exception {

      Integer sesAdmns = (Integer) session.getAttribute("admns");
      String sesDept = (String) session.getAttribute("dept");
      logger.debug("세션등록 admns : " + sesAdmns + ", dept : " + sesDept);

      String dcdKeyword = URLDecoder.decode(keyword, StandardCharsets.UTF_8);
      String dcdKeyword2 = URLDecoder.decode(keyword2, StandardCharsets.UTF_8);
      String dcdSearchField = URLDecoder.decode(searchField, StandardCharsets.UTF_8);
      String dcdColumn = URLDecoder.decode(column, StandardCharsets.UTF_8);
      String dcdSortOrder = URLDecoder.decode(sortOrder, StandardCharsets.UTF_8);

      AprvCriteria cri = new AprvCriteria();

      cri.setPage(page);
      cri.setPerPageNum(perPageNum);
      cri.setKeyword(dcdKeyword);
      cri.setKeyword2(dcdKeyword2);
      cri.setSearchField(dcdSearchField);
      cri.setColumn(dcdColumn);
      cri.setSortOrder(dcdSortOrder);
      cri.setSesAdmns(sesAdmns);
      cri.setSesDept(sesDept);

      List<AprvDTO> list = service.aprvList(cri);

      int totalCount = service.getTotalCountAprv(cri);

      PageMaker pageMaker = new PageMaker(cri, totalCount);

      model.addAttribute("cri", cri);
      model.addAttribute("list", list);
      model.addAttribute("pageMaker", pageMaker);

      return "aprv/aprvList";
   }

   @GetMapping("/ptoApply")
   public String ptoApply(Model model, HttpSession session) throws Exception {
      String empno = (String) session.getAttribute("id");

      // 추가 정보를 가져오기 위해 서비스 레이어의 메서드 호출
      AprvDTO info = service.getApplyInfo(empno);

      // 모델에 추가 정보를 추가
      model.addAttribute("empno", empno);
      model.addAttribute("codenm", info.getCodenm());
      model.addAttribute("totalpto", info.getTotalpto());
      model.addAttribute("rstpto", info.getRstpto());

      return "aprv/ptoApply";
   }

   @PostMapping("/ptoApply")
   public String register(AprvDTO avo, RedirectAttributes rttr, HttpServletRequest request) throws Exception {
      request.setCharacterEncoding("utf-8");
      int r = service.ptoApply(avo);

      if (r < 0) {
         return "redirect:/ptoApply";
      }
      rttr.addFlashAttribute("pno", avo.getPno());
      return "redirect:aprvDetail?source=ptoList&pno=" + avo.getPno();
   }

   @GetMapping("/aprvDetail")
   public String ptoDetail(@RequestParam("pno") int pno, Model model) throws Exception {
      logger.debug(pno + "번 결재 상세 조회 Controller");
      AprvDTO aprv = service.aprvDetail(pno);
      model.addAttribute("aprv", aprv);
      return "aprv/aprvDetail";
   }

   @GetMapping("/ptoModify")
   public String ptoModify(@RequestParam("pno") int pno, Model model) throws Exception {
      AprvDTO aprv = service.aprvDetail(pno);
      model.addAttribute("aprv", aprv);
      return "aprv/ptoModify";
   }

   @PostMapping("/ptoModify")
   public String ptoModify(AprvDTO aprv, RedirectAttributes rttr, HttpServletRequest req) throws Exception {
      logger.info("ptotp");
      req.setCharacterEncoding("utf-8");
      int r = service.ptoModify(aprv);

      if (r > 0) {
         rttr.addFlashAttribute("msg", "수정이 완료되었습니다.");
         return "redirect:aprvDetail?source=ptoList&pno=" + aprv.getPno();
      }
      return "redirect:/ptoModify?pno=" + aprv.getPno();
   }

   @GetMapping("/ptoDel")
   public String ptoDel(@RequestParam("pno") int pno, RedirectAttributes rttr) throws Exception {
      int r = service.ptoDel(pno);
      if (r > 0) {
         rttr.addFlashAttribute("msg", "삭제 되었습니다.");
         return "redirect:/ptoList";
      }
      return "redirect:aprvDetail?pno=" + pno;
   }

   @PostMapping("/ptoDel")
   @ResponseBody
   public Map<String, String> ptoDelPost(@RequestBody List<Integer> pnoList) throws Exception {
      Map<String, String> resultMap = new HashMap<>();

      try {
         for (Integer pno : pnoList) {
            service.ptoDel(pno);
         }
         resultMap.put("msg", "삭제되었습니다.");
      } catch (Exception e) {
         resultMap.put("msg", "삭제 중 오류가 발생했습니다.");
      }

      return resultMap;
   }

   @PostMapping("/aprv")
   public String aprv(AprvDTO aprv, HttpServletRequest request, RedirectAttributes rttr) throws Exception {
      logger.debug(aprv.getPno() + "번 결재 Controller");
      request.setCharacterEncoding("UTF-8");
      logger.debug(aprv.getEmpno());
      int row = service.aprv(aprv);
      if (row > 0) {
         logger.debug(aprv.getPno() + "번 결재 성공 Controller");
         webSocketHandler.sendMessageToUser("휴가" , aprv.getEmpno(), Integer.toString(aprv.getPno()), aprv.getApprver());
         rttr.addFlashAttribute("msg", "결재가 완료되었습니다.");
      } else {
         logger.debug(aprv.getPno() + "번 결재 실패 Controller");
      }
      return "redirect:/aprvDetail?source=aprvList&pno=" + aprv.getPno();
   }
}
