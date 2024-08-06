package com.mbc.academy.empolyloginandsearch;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.mbc.academy.emp.EmpDTO;

@Service
public class LEmplistServiceimpls implements LEmplistService {

	@Autowired
	private LEmpDAO empDAO ;
	
	
	@Override
	public List<LEmpDTO> getemplist(LCriteria cri) throws Exception {
		return empDAO.getemplist(cri);
	}
	@Override
	public LEmpDTO getempdetail(String empno) throws Exception {
		return empDAO.getempdetail(empno);
	}
	@Override
	public List<LEmpDTO> getempsearch(String searchText, String searchSelect, LCriteria cri) throws Exception {
		return empDAO.getempsearch(searchText, searchSelect, cri);
	}
	@Override
	public LEmpDTO getallList(String userid) throws Exception {
		return empDAO.getallList(userid);
	}
	@Override
	public void changepw(String userID , String cpw2) throws Exception {
		empDAO.changepw(userID, cpw2);
	}
	@Override
	public Map<String, Object> updateprofile(Map<String, Object> usercprofile) throws Exception {
		empDAO.updateprofile(usercprofile);
		return null;
	}
	@Override
	public void aempolychange(EmpDTO emp) throws Exception {
		empDAO.aempolychange(emp);
		
	}
	@Override
	public boolean checkUser(String empno, String email) throws Exception {
		return empDAO.checkUser(empno, email);
	}
	@Override
	public boolean newPwUpdate(String empno, String newPw) throws Exception {
		return empDAO.newPwUpdate(empno, newPw);
	}
	@Override
	public int countList() throws Exception {
		return empDAO.countList();
	}
	@Override
	public int countsearchList(String searchText , String searchSelect) throws Exception {
		return empDAO.countsearchList(searchText, searchSelect);
	}
	@Override
	public void deleteemp(String empno) throws Exception {
		empDAO.deleteemp(empno);
		
	}
}
