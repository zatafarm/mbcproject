package com.mbc.academy.aprv;

import java.util.List;

public interface AprvDAO {

	public List<AprvDTO> aprvList(AprvCriteria cri) throws Exception;
	public List<AprvDTO> aprvListMain(AprvCriteria cri) throws Exception;
	public int getTotalCountAprv(AprvCriteria cri) throws Exception;
	public List<AprvDTO> ptoList(AprvCriteria cri) throws Exception;
	public List<AprvDTO> ptoListMain(AprvCriteria cri) throws Exception;
	public int getTotalCountPto(AprvCriteria cri) throws Exception;
	public int ptoApply(AprvDTO avo) throws Exception;
	public AprvDTO aprvDetail(int pno) throws Exception;
	public int ptoModify(AprvDTO avo) throws Exception;
	public int ptoDel(int pno) throws Exception;
	public int aprv(AprvDTO aprv) throws Exception;
	public int updatePTO(AprvDTO aprv) throws Exception;	// 연차 개수 업데이트
	public int updateHalfPTO(AprvDTO aprv) throws Exception;// 반차 개수 업데이트
	public int insertATST(AprvDTO aprv) throws Exception;// 근태 휴가 업데이트
	public AprvDTO getApplyInfo(String empno) throws Exception;
}