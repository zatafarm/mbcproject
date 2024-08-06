package com.mbc.academy.chnemp;

import java.util.List;

public interface ChnempService {
	public List<ChnempDTO> empChnList(ChnempCriteria cri) throws Exception;
	public int getTotalCountChnemp(ChnempCriteria cri) throws Exception;
	public ChnempDTO empChnDetail(int chno) throws Exception;
	public int empChnDel(int chno) throws Exception;
	public int confirmChn(ChnempDTO chninfo) throws Exception;
	public int empChnApply(ChnempDTO dto) throws Exception;
	public int empChnModify(ChnempDTO dto) throws Exception;
	public List<ChnempDTO> empChnMainList() throws Exception;
}
