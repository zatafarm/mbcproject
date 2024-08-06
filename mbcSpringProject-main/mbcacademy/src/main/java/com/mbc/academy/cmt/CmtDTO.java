package com.mbc.academy.cmt;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CmtDTO {
    private int bno; // 게시글 번호
    private int cno1; // 댓글 일련번호
    private int cno2; // 대댓글 일련번호
    private String empno; // 사번
    private String ename; // 이름
    private String cmt1; // 댓글
    private String cmt2; // 대댓글
    private int parent_cno; // 부모 댓글 번호
    private String cmtdt1; // 댓글 등록일자
    private String cmtdt2; // 대댓글 등록일자
    private String cmtudt1; // 댓글 수정일자
    private String cmtudt2; // 대댓글 수정일자
    private int delc1; // 댓글 삭제여부
    private int delc2; // 대댓글 삭제여부
    private int rprc1; // 댓글 신고여부
    private int rprc2; // 대댓글 신고여부
    private int delreac1; // 댓글 삭제사유
    private int delreac2; // 대댓글 삭제사유
}