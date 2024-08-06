package com.mbc.academy.empolyloginandsearch;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mbc.academy.emp.EmpDTO;

@Repository
public class LEmpDAOimpls implements LEmpDAO {
	@Autowired
	   private SqlSession sqlsession;
	   
	   private static final String namespace = "com.mbc.academy.mapper.empoly";

	@Override
	public List<LEmpDTO> getemplist(LCriteria cri) throws Exception {
		  return sqlsession.selectList(namespace + ".getemplist", cri);
	}
	
	@Override
	public LEmpDTO getempdetail(String empno) throws Exception {
		  return sqlsession.selectOne(namespace + ".getempdetail", empno);
	}

	@Override
	public List<LEmpDTO> getempsearch(String searchText, String searchSelect, LCriteria cri) throws Exception {
	    Map<String, Object> cs = new HashMap<>();
	    cs.put("searchText", searchText);
	    cs.put("cri", cri);
	    cs.put("Page", cri.getPage());
	    cs.put("PageStart", cri.getPageStart());
	    cs.put("PerPageNum", cri.getPerPageNum());
		if(searchSelect.equals("detpsearch")) {
		return sqlsession.selectList(namespace + ".getempsearchdetp", cs);
		}
		else if (searchSelect.equals("namesearch")) {
		return sqlsession.selectList(namespace + ".getempsearchname", cs);	
		}
		return null;
	}

	@Override
	public LEmpDTO getallList(String userid) throws Exception {
		LEmpDTO dto = sqlsession.selectOne(namespace + ".getallList" , userid);
		if (dto != null) {
			return dto;
		}
		else {
			return null;
		}
		
	}

	@Override
	public void changepw(String userID, String cpw2) throws Exception {
	    Map<String, Object> user = new HashMap<>();
	    user.put("userID", userID);
	    user.put("cpw2", cpw2);
	    
	    sqlsession.update(namespace + ".changepw", user);
	}

	@Override
	public void updateprofile(Map<String, Object> usercprofile) throws Exception {
		  sqlsession.update(namespace + ".updateprofile", usercprofile);
		
	}

	@Override
	public void aempolychange(EmpDTO emp) throws Exception {
		sqlsession.update(namespace + ".updateadminempoly", emp);
	}

	@Override
	public boolean checkUser(String empno, String email) throws Exception {
		Map<String, String> params = new HashMap<>();
		params.put("empno", empno);
		params.put("email", email);
		int count = sqlsession.selectOne(namespace + ".checkUser", params);
		return count > 0;
	}

	@Override
	public boolean newPwUpdate(String empno, String newPw) throws Exception {
		Map<String, String> params = new HashMap<>();
		params.put("empno", empno);
		params.put("newPw", newPw);
		int result = sqlsession.update(namespace + ".newPwUpdate", params);
		return result > 0;
	}

	@Override
	public int countList() throws Exception {
	 	int a = sqlsession.selectOne(namespace + ".countlist");
	 	return a;
	}

	@Override
	public int countsearchList(String searchText , String searchSelect) throws Exception {
		int a = 0;	
		if(searchSelect.equals("detpsearch")) {
			a = sqlsession.selectOne(namespace + ".searchcountlistdetp", searchText);
			}
			else if (searchSelect.equals("namesearch")) {				
			a = sqlsession.selectOne(namespace + ".searchcountlistname", searchText);
			}
			return a;
	}

	@Override
	public void deleteemp(String empno) throws Exception {
		Map<String, String> params = new HashMap<>();
		params.put("empno", empno);
		  LocalDate now = LocalDate.now();
		  DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		  String Rdate = now.format(formatter);
		params.put("Rdate", Rdate);
		sqlsession.update(namespace + ".deleteemp", params );
		
	}
}
