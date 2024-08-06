package com.mbc.academy.chnemp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChnempServiceImpl implements ChnempService{
	
	@Autowired
	ChnempDAO chnempDAO;

	@Override
	public ChnempDTO empChnDetail(int chno) throws Exception {
		return chnempDAO.empChnDetail(chno);
	}

	@Override
	public int empChnDel(int chno) throws Exception {
		return chnempDAO.empChnDel(chno);
	}

	@Override
	public int confirmChn(ChnempDTO chninfo) throws Exception {
		return chnempDAO.confirmChn(chninfo);
	}

	@Override
	public List<ChnempDTO> empChnList(ChnempCriteria cri) throws Exception {
		return chnempDAO.empChnList(cri);
	}

	@Override
	public int getTotalCountChnemp(ChnempCriteria cri) throws Exception {
		return chnempDAO.getTotalCountChnemp(cri);
	}

	@Override
	public int empChnApply(ChnempDTO dto) throws Exception {
		int result = chnempDAO.empChnApply(dto);
		System.out.println("Service 정정신청등록 시도");
		if(result == 0) {
			System.out.println("Service 정정신청등록 실패");
		} else {
			System.out.println("Service 정정신청등록 성공");
		}
		return result;
	}

	@Override
	public int empChnModify(ChnempDTO dto) throws Exception {
		int result = chnempDAO.empChnModify(dto);
		System.out.println("Service 정정신청수정 시도");
		if(result == 0) {
			System.out.println("Service 정정신청수정 실패");
		} else {
			System.out.println("Service 정정신청수정 성공");
		}
		return result;
	}

	@Override
	public List<ChnempDTO> empChnMainList() throws Exception {
		// TODO Auto-generated method stub
		return chnempDAO.empChnMainList();
	}


}
