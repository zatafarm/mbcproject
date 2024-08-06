package com.mbc.academy.empolyloginandsearch;

import java.util.List;
import java.util.Map;

import com.mbc.academy.emp.EmpDTO;

public interface LEmpDAO {
	public LEmpDTO getallList(String userid) throws Exception;
	public List<LEmpDTO> getemplist(LCriteria cri) throws Exception;
	public void deleteemp(String empno) throws Exception;
	public LEmpDTO getempdetail(String empno) throws Exception;
	public List<LEmpDTO> getempsearch(String searchText , String searchSelect , LCriteria cri) throws Exception;
	public void changepw(String userID , String cpw2) throws Exception;
	public void updateprofile(Map<String, Object> usercprofile) throws Exception;
	public void aempolychange(EmpDTO emp) throws Exception;
	public boolean checkUser(String empno, String email) throws Exception;
	public boolean newPwUpdate(String empno, String newPw) throws Exception;
	public int countList() throws Exception;
	public int countsearchList(String searchText , String searchSelect) throws Exception;
}
