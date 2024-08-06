package com.mbc.academy.board;

import java.util.List;

import org.springframework.stereotype.Service;


@Service

public interface MbcService {
	
	//메인화면
	public List<MbcDTO> getlist() throws Exception;
	public List<MbcDTO> listrprb() throws Exception;
	public List<MbcDTO> getaumlist() throws Exception;
	
	//사내게시판
	public List<MbcDTO> list(MbcCriteria cri) throws Exception;
	public int getTotalCountBoard(MbcCriteria cri) throws Exception;
	public List<MbcDTO> mylist(MbcCriteria cri) throws Exception;
	public int getTotalCountMyBoard(MbcCriteria cri) throws Exception;
	public int updateReadCnt(int bno) throws Exception;
	public int update(MbcDTO dto) throws Exception;
	public int register(MbcDTO dto) throws Exception;
	public int delete(int bno) throws Exception;
	public int admnDelete(int bno, String delrea) throws Exception;
	public MbcDTO detail(int bno) throws Exception;
	public int updateRprb(int bno) throws Exception;
	
	//공지사항
	public List<MbcDTO> aumlist(MbcCriteria cri) throws Exception;
	public int getTotalAum(MbcCriteria cri) throws Exception;
}
