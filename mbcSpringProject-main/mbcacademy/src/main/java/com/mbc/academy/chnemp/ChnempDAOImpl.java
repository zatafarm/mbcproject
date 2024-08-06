package com.mbc.academy.chnemp;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChnempDAOImpl implements ChnempDAO {

	@Autowired
	private SqlSession sqlsession;
	
	private static final String NAMESPACE = "com.mbc.academy.chnempMapper";

	@Override
	public ChnempDTO empChnDetail(int chno) throws Exception {
		return sqlsession.selectOne(NAMESPACE + ".empChnDetail", chno);
	}

	@Override
	public int empChnDel(int chno) throws Exception {
		return sqlsession.update(NAMESPACE + ".empChnDel", chno);
	}

	@Override
	public int confirmChn(ChnempDTO chninfo) throws Exception {
		return sqlsession.update(NAMESPACE + ".confirmChn", chninfo);
	}

	@Override
	public List<ChnempDTO> empChnList(ChnempCriteria cri) throws Exception {
		return sqlsession.selectList(NAMESPACE + ".empChnList", cri);
	}

	@Override
	public int getTotalCountChnemp(ChnempCriteria cri) throws Exception {
		return sqlsession.selectOne(NAMESPACE + ".getTotalCountChnemp", cri);
	}

	@Override
	public int empChnApply(ChnempDTO dto) throws Exception {
		int result = sqlsession.insert(NAMESPACE + ".empChnApply", dto);
		System.out.println("DAO 정정신청등록 시도");
		if(result == 0) {
			System.out.println("DAO 정정신청등록 실패");
		} else {
			System.out.println("DAO 정정신청등록 성공");
		}
		return result;
	}

	@Override
	public int empChnModify(ChnempDTO dto) throws Exception {
		int result = sqlsession.insert(NAMESPACE + ".empChnModify", dto);
		System.out.println("DAO 정정신청수정 시도");
		if(result == 0) {
			System.out.println("DAO 정정신청수정 실패");
		} else {
			System.out.println("DAO 정정신청수정 성공");
		}
		return result;
	}

	@Override
	public List<ChnempDTO> empChnMainList() throws Exception {
		return sqlsession.selectList(NAMESPACE + ".empChnMainList");
	}
}
