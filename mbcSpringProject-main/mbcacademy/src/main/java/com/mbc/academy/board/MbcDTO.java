package com.mbc.academy.board;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@Getter
@Setter
public class MbcDTO {
	
	private int bno;//순번
	private String ttl;//제목
	private String cnt;//내용
	private String empno;//사번
	private String ename;//작성자이름
	private String regdt;//작성일
	private String udtdt;//수정일
	private int udtcnt;//조회수
	private int del;//삭제여부
	private String delrea;//삭제사유
	private int chk;//사내게시판 익명1, 공지사항 우선순위 2 
	private int rprb;//신고
	 private List<MultipartFile> files = new ArrayList<>();    

	 private List<Integer> removeFileIds = new ArrayList<>(); // 삭제할 첨부파일 id List
	

}
