package com.mbc.academy.emp;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class EmpDAOImpl implements EmpDAO {

	@Autowired
	private SqlSession sqlsession;
	
	private static final String NAMESPACE = "com.mbc.academy.empMapper";
	
	@SuppressWarnings("rawtypes")
	@Override
	public Map login(Map<String, Object> map) throws Exception {
		Map result = sqlsession.selectOne(NAMESPACE+".login",map);
		System.out.println(result + "로그인시도DAO");
		return result;
	}
	
	@Override
	public int signUp(EmpDTO emp) throws Exception {
		System.out.println("사원등록 시도 DAO");
		int result1 = sqlsession.insert(NAMESPACE + ".insertEmp", emp);
		int result2 = sqlsession.insert(NAMESPACE + ".insertPtoInfo", emp);
		if (result1 > 0 && result2 > 0) {
            System.out.println("사원등록 성공 DAO");
        } else {
            System.out.println("사원등록 실패 DAO");
        }
		return (result1 > 0 && result2 > 0) ? 1 : 0;
	}

	@Override
	public int atGnrEmpno(String year) throws Exception {
		System.out.println("사번자동생성 시도 DAO - 입력된 연도: " + year);
		int result = sqlsession.selectOne(NAMESPACE + ".atGnrEmpno", year);
		System.out.println("사번자동생성 성공 DAO - 데이터베이스에서 반환된 값: " + result);
		return result;
	}
	
	@Override
	public List<EmpDTO> empList() throws Exception {
		System.out.println("사원리스트조회 DAO");
		return sqlsession.selectList(NAMESPACE + ".list");
	}

	@Override
	public List<EmpDTO> getEmployeesByDeptAndAdmns(String dept, int admns) throws Exception {
		Map<String, Object> parameterMap = new HashMap<>();
        parameterMap.put("dept", dept);
        parameterMap.put("admns", admns);
        return sqlsession.selectList(NAMESPACE + ".getEmployeesByDeptAndAdmns", parameterMap);
	}

	@Override
	public EmpDTO searchEmpChn(String empno) throws Exception {
		System.out.println("DAO: " + empno + "조회" );
		return sqlsession.selectOne(NAMESPACE + ".searchEmpChn", empno);
	}
}
