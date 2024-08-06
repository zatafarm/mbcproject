package com.mbc.academy.aprv;

import java.util.List;

public interface AprvService {
	
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
	public AprvDTO getApplyInfo(String empno) throws Exception;
}
