package com.mbc.academy.cmt;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mbc.academy.socket.WebSocketHandler;

@Controller
public class CmtController {
    
    private static final Logger logger = LoggerFactory.getLogger(CmtController.class);

    @Autowired
    CmtService service;

    @Autowired
    WebSocketHandler  webSocketHandler;
    
    // 댓글 등록
    @PostMapping("/cmtRegister1")
    public String cmtRegister1(CmtDTO dto, HttpSession session, RedirectAttributes rttr) throws Exception {
        String loginEmpno = (String) session.getAttribute("id");
        int r = service.cmtRegister1(dto);
        rttr.addFlashAttribute("msg", "댓글이 등록되었습니다."); // 등록 메시지를 추가
        String target = service.getpostempno(dto.getBno());
        
        webSocketHandler.sendMessageToUser("댓글" ,  target , Integer.toString(dto.getBno()), loginEmpno);
        // 댓글 목록 페이지로 리다이렉트
        return "redirect:/detail?bno=" + dto.getBno() + "&source=list";
    }
    
    // 대댓글 등록
    @PostMapping("/cmtRegister2")
    public String cmtRegister2(CmtDTO dto, HttpSession session, RedirectAttributes rttr) throws Exception {
        // 현재 로그인된 사용자의 사번을 세션에서 가져오기
        String loginEmpno = (String) session.getAttribute("id");
        dto.setEmpno(loginEmpno);
        
        // 대댓글 등록
        int r = service.cmtRegister2(dto);
        rttr.addFlashAttribute("msg", "답글이 등록되었습니다."); // 등록 메시지를 추가
        String target = service.getpostempno(dto.getBno());        
        webSocketHandler.sendMessageToUser("댓글" ,  target , Integer.toString(dto.getBno()), loginEmpno);
        // 댓글 목록 페이지로 리다이렉트
        return "redirect:/detail?bno=" + dto.getBno() + "&source=list";
    }



    // 댓글 수정
    @PostMapping("/cmtUpdate1")
    public String cmtUpdate1(CmtDTO dto, RedirectAttributes rttr) throws Exception {
        service.cmtUpdate1(dto);
        rttr.addFlashAttribute("msg", "댓글이 수정되었습니다.");
        // 댓글 목록 페이지로 리다이렉트
        return "redirect:/detail?bno=" + dto.getBno() + "&source=list";
    }
    
    // 댓글 수정
    @PostMapping("/cmtUpdate2")
    public String cmtUpdate2(CmtDTO dto, RedirectAttributes rttr) throws Exception {
        service.cmtUpdate2(dto);
        rttr.addFlashAttribute("msg", "댓글이 수정되었습니다.");
        // 댓글 목록 페이지로 리다이렉트
        return "redirect:/detail?bno=" + dto.getBno() + "&source=list";
    }

    // 댓글 삭제
    @PostMapping("/delc1")
    public String deleteComment(@RequestParam("cno1") int cno1, @RequestParam("bno") int bno, RedirectAttributes rttr) {
        try {
            // 댓글 삭제 수행
            service.delc1(cno1);
            // 삭제가 성공했을 경우 메시지를 설정하여 목록 페이지로 리다이렉트
            rttr.addFlashAttribute("successMessage", "댓글이 성공적으로 삭제되었습니다.");
        } catch (Exception e) {
            // 삭제가 실패했을 경우 메시지를 설정하여 이전 페이지로 리다이렉트
            rttr.addFlashAttribute("errorMessage", "댓글 삭제 중 오류가 발생했습니다.");
        }
        // 댓글이 속한 게시물 상세 페이지로 리다이렉트
        return "redirect:/detail?bno=" + bno + "&source=list";
    }
    
    // 댓글 삭제
    @PostMapping("/delc2")
    public String deleteComment2(@RequestParam("cno2") int cno2, @RequestParam("bno") int bno, RedirectAttributes rttr) {
        try {
            // 댓글 삭제 수행
            service.delc2(cno2);
            // 삭제가 성공했을 경우 메시지를 설정하여 목록 페이지로 리다이렉트
            rttr.addFlashAttribute("successMessage", "댓글이 성공적으로 삭제되었습니다.");
        } catch (Exception e) {
            // 삭제가 실패했을 경우 메시지를 설정하여 이전 페이지로 리다이렉트
            rttr.addFlashAttribute("errorMessage", "댓글 삭제 중 오류가 발생했습니다.");
        }
        // 댓글이 속한 게시물 상세 페이지로 리다이렉트
        return "redirect:/detail?bno=" + bno + "&source=list";
    }
    
    
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    // 대댓글
}
