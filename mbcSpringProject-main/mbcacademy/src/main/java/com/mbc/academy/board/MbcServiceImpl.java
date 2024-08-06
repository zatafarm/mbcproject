package com.mbc.academy.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service

public class MbcServiceImpl implements MbcService {

	@Autowired
	MbcDAO dao;

	
	//메인화면
	@Override
	public List<MbcDTO> getlist() throws Exception {
		// TODO Auto-generated method stub
		return dao.getlist();
	}
	
	@Override
	public List<MbcDTO> listrprb() throws Exception {
		// TODO Auto-generated method stub
		return dao.listrprb();
	}

	@Override
	public List<MbcDTO> getaumlist() throws Exception {
		// TODO Auto-generated method stub
		return dao.getaumlist();
	}

	
	// 사내게시판
	@Override
	public List<MbcDTO> list(MbcCriteria cri) throws Exception {
		System.out.println("list창 진입 Service");
		return dao.list(cri);
	}

	@Override
	public int getTotalCountBoard(MbcCriteria cri) throws Exception {
		return dao.getTotalCountBoard(cri);
	}

	@Override
	public List<MbcDTO> mylist(MbcCriteria cri) throws Exception {
		System.out.println("list창 진입 Service");
		return dao.mylist(cri);
	}

	@Override
	public int getTotalCountMyBoard(MbcCriteria cri) throws Exception {
		return dao.getTotalCountMyBoard(cri);
	}

	@Override
	public int updateReadCnt(int bno) throws Exception {
		// TODO Auto-generated method stub
		return dao.updateReadCnt(bno);
	}

	@Override
	public int update(MbcDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return dao.update(dto);
	}

	@Override
	public int register(MbcDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return dao.register(dto);
	}

	@Override
	public int delete(int bno) throws Exception {
		return dao.delete(bno);
	}

	@Override
	public int admnDelete(int bno, String delrea) throws Exception {
		return dao.admnDelete(bno, delrea);
	}

	@Override
	public MbcDTO detail(int bno) throws Exception {
		// TODO Auto-generated method stub
		return dao.detail(bno);
	}

	// 공지사항

	@Override
	public List<MbcDTO> aumlist(MbcCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return dao.aumlist(cri);
	}

	@Override
	public int getTotalAum(MbcCriteria cri) throws Exception {
		return dao.getTotalAum(cri);
	}

	@Override
	public int updateRprb(int bno) throws Exception {
		// TODO Auto-generated method stub
		return dao.updateRprb(bno);
	}


}
