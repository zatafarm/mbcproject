package com.mbc.academy.emp;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class EmpServiceImpl implements EmpService {
	
	@Autowired
	EmpDAO empDAO;

	@SuppressWarnings("rawtypes")
	@Override
	public Map login(Map<String, Object> map) throws Exception {
		Map result = empDAO.login(map);
		System.out.println(result + "Service");
		return result;
	}
	
	@Override
	@Transactional
	public int signUp(EmpDTO emp) throws Exception {
		System.out.println("사원등록 시도 Service");
		int result = empDAO.signUp(emp);
		if (result > 0) {
			System.out.println("사원등록 성공 Service");
		} else {
			System.out.println("사원등록 실패 Service");
		}
		return result;
	}
	
	@Override
	public int atGnrEmpno(String year) throws Exception {
		System.out.println("사번자동생성 시도 Service - 입력된 연도: " + year);
		int cnt = empDAO.atGnrEmpno(year) + 1;
		System.out.println("사번자동생성 성공 Service - 생성된 카운트: " + (cnt));
		return cnt;
	}

	@Override
	public List<EmpDTO> empList() throws Exception {
		System.out.println("사원리스트조회 Service");
		return empDAO.empList();
	}

	@Override
	 public List<EmpDTO> getEmployeesByDeptAndAdmns(String dept, int admns) throws Exception {
        // 부서와 권한을 기준으로 직원을 조회하는 로직을 구현
        // 예를 들어, DAO를 통해 DB에서 직원을 조회한 후 반환
        return empDAO.getEmployeesByDeptAndAdmns(dept, admns);
    }
	
	@Override
	public EmpDTO searchEmpChn(String empno) throws Exception {
		System.out.println("Service: " + empno + "조회" );
		return empDAO.searchEmpChn(empno);
	}

}
