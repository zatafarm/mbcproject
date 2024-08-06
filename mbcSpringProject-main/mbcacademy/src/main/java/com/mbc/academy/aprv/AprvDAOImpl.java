package com.mbc.academy.aprv;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AprvDAOImpl implements AprvDAO {

	@Autowired
	private SqlSession sqlsession;
	private static final String namespace = "com.mbc.academy.aprvMapper";
	private static final Logger logger = LoggerFactory.getLogger(AprvDAOImpl.class);

	@Override
	public List<AprvDTO> aprvList(AprvCriteria cri) throws Exception {
		logger.debug("결재 리스트 조회 DAO");
		return sqlsession.selectList(namespace + ".aprvList", cri);
	}
	
	@Override
	public List<AprvDTO> aprvListMain(AprvCriteria cri) throws Exception {
		return sqlsession.selectList(namespace + ".aprvListMain", cri);
	}
	@Override
	public int getTotalCountAprv(AprvCriteria cri) throws Exception {
		return sqlsession.selectOne(namespace + ".getTotalCountAprv", cri);
	}

	@Override
	public List<AprvDTO> ptoList(AprvCriteria cri) throws Exception {
		logger.debug("신청 리스트 조회 DAO");
		return sqlsession.selectList(namespace + ".ptoList", cri);
	}
	
	@Override
	public List<AprvDTO> ptoListMain(AprvCriteria cri) throws Exception {
		return sqlsession.selectList(namespace + ".ptoListMain", cri);
	}

	@Override
	public int getTotalCountPto(AprvCriteria cri) throws Exception {
		return sqlsession.selectOne(namespace + ".getTotalCountPto", cri);
	}

	@Override
	public int ptoApply(AprvDTO avo) throws Exception {
		return sqlsession.insert(namespace + ".ptoApply", avo);
	}

	@Override
	public AprvDTO aprvDetail(int pno) throws Exception {
		logger.debug(pno + "번 결재 상세 조회 DAO");
		return sqlsession.selectOne(namespace + ".aprvDetail", pno);
	}

	@Override
	public int ptoModify(AprvDTO avo) throws Exception {
		return sqlsession.update(namespace + ".ptoModify", avo);
	}

	@Override
	public int ptoDel(int pno) throws Exception {
		return sqlsession.delete(namespace + ".ptoDel", pno);
	}

	@Override
	public int aprv(AprvDTO aprv) throws Exception {
		logger.debug(aprv.getPno() + "번 결재 DAO");
		return sqlsession.update(namespace + ".aprv", aprv);
	}

	@Override
	public int updatePTO(AprvDTO aprv) throws Exception {
		logger.debug(aprv.getEmpno() + "연차 +" + aprv.getUsp() + "업데이트 Service");
		return sqlsession.update(namespace + ".updatePTO", aprv);
	}

	@Override
	public int updateHalfPTO(AprvDTO aprv) throws Exception {
		logger.debug(aprv.getEmpno() + "반차 +" + aprv.getUsp() + "업데이트 Service");
		return sqlsession.update(namespace + ".updateHalfPTO", aprv);
	}
	
	public int insertATST(AprvDTO aprv) throws Exception {
		logger.debug(aprv.getEmpno() + "근태 업데이트 Service");
		return sqlsession.insert(namespace + ".insertATST", aprv);
	}

	@Override
	public AprvDTO getApplyInfo(String empno) throws Exception {
		return sqlsession.selectOne(namespace + ".getApplyInfo", empno);
	}

}
