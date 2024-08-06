package com.mbc.academy.cmt;

import java.util.List;

import org.springframework.stereotype.Service;

@Service

public interface CmtService {
	public List<CmtDTO> cmtList1(int bno) throws Exception;//댓글 목록
	public List<CmtDTO> cmtList2(List<CmtDTO> cnolist) throws Exception;//대댓글 목록
	public List<CmtDTO> cnoList(int bno) throws Exception;
	public int cmtRegister1(CmtDTO dto) throws Exception;//댓글 작성
	public int cmtRegister2(CmtDTO dto) throws Exception;//대댓글 작성
	public int cmtUpdate1(CmtDTO dto) throws Exception;//댓글 수정
	public int cmtUpdate2(CmtDTO dto) throws Exception;//대댓글 수정
	public int delc1(int bno) throws Exception;//댓글 삭제여부
	public int delc2(int cno1) throws Exception;//대댓글 삭제여부
	public String getpostempno(int bno) throws Exception;
	
}
