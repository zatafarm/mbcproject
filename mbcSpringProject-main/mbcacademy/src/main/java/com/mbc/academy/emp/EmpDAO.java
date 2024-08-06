package com.mbc.academy.emp;

import java.util.List;
import java.util.Map;

public interface EmpDAO {
	@SuppressWarnings("rawtypes")
	public Map login(Map<String,Object> map) throws Exception;
	public int signUp(EmpDTO emp) throws Exception;
	int atGnrEmpno(String year) throws Exception;
	public List<EmpDTO> empList() throws Exception;
	public List<EmpDTO> getEmployeesByDeptAndAdmns(String dept, int admns) throws Exception;
	public EmpDTO searchEmpChn(String empno) throws Exception;
}
