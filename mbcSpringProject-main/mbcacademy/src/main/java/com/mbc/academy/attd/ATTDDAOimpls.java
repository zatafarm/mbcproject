package com.mbc.academy.attd;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ATTDDAOimpls implements ATTDDAO {
	@Autowired
	private SqlSession sqlsession;

	private static final String namespace = "com.mbc.academy.mapper.attd";
	private static final Logger logger = LoggerFactory.getLogger(ATTDDAOimpls.class);

	@Override
	public int gettoday(LocalDate today) throws Exception {
		int result = sqlsession.selectOne(namespace + ".gettoday", today);
		logger.debug("DAO 날짜 조회" + result);
		return result;
	}

	@Override
	public List<AttdDTO> getallempno() throws Exception {
		return sqlsession.selectList(namespace + ".getallempno");
	}

	@Override
	public void allinserttoday(List<AttdDTO> attdempno) throws Exception {
		for (int a = 0; a < attdempno.size(); a++) {
			String empno = attdempno.get(a).getEMPNO();
			sqlsession.insert(namespace + ".inserttoday", empno);
			logger.debug("DAO" + empno + "하루 일괄 삽입");
		}
		for (int a = 0; a < attdempno.size(); a++) {
			String empno = attdempno.get(a).getEMPNO();
			sqlsession.insert(namespace + ".pluscuma", empno);
			logger.debug("DAO" + empno + "근태 일괄 삽입");
		}
	}

	@Override
	public void inserttoday(String empno) throws Exception {
		sqlsession.insert(namespace + ".inserttoday", empno);
	}

	@Override
	public String gtwselectone(String empno) {
		String gtw = sqlsession.selectOne(namespace + ".gtw", empno);
		logger.debug("DAO" + gtw);
		return gtw;
	}

	@Override
	public void gtw(String empno) throws Exception {
		Map<String, Object> user = new HashMap<>();
		user.put("empno", empno);
		String atst = gtwselectone(empno);
		LocalTime now = LocalTime.now();
		String timeString = sqlsession.selectOne(namespace + ".getsttime");
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
		LocalTime tardy = LocalTime.parse(timeString, formatter);
		System.out.println(tardy);
		if (now.isBefore(tardy)) {
			if (atst.equals("A4")) {
				atst = "A4";
			} else {
				atst = "A1";
			}
			user.put("atst", atst);
			user.put("nowtime", now);
			sqlsession.update(namespace + ".atstchange", user);
		} else if (now.isAfter(tardy)) {
			if (atst.equals("A4")) {
				atst = "A4";
			} else {
				atst = "A3";
			}
			user.put("atst", atst);
			user.put("nowtime", now);
			sqlsession.update(namespace + ".atstchange", user);
			sqlsession.update(namespace + ".pluscump", user);
		}
	}

	@Override
	public int gow(String empno) throws Exception {
		Map<String, Object> user = new HashMap<>();
		user.put("empno", empno);
		String atst = gtwselectone(empno);
		LocalTime now = LocalTime.now();
		String timeString = sqlsession.selectOne(namespace + ".getentime");
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");
		LocalTime entime = LocalTime.parse(timeString, formatter);
		if (atst.equals("A4")) {
			atst = "A4";
			user.put("atst", atst);
			user.put("nowtime", now);
			sqlsession.update(namespace + ".gowchange", user);
			return 1;
		} else if (now.isAfter(entime)) {
			atst = "A2";
			user.put("atst", atst);
			user.put("nowtime", now);
			sqlsession.update(namespace + ".gowchange", user);
			return 1;
		} else {
			return 0;
		}
	}

	@Override
	public void settimest(String sttime) throws Exception {
		sqlsession.update(namespace + ".strtmchange", sttime);

	}

	@Override
	public void settimeen(String entime) throws Exception {
		sqlsession.update(namespace + ".endtmchange", entime);

	}

	@Override
	public List<AttdDTO> gtwlist(String empno) throws Exception {

		return sqlsession.selectList(namespace + ".getgtwlist", empno);
	}

	@Override
	public List<AttdDTO> gtwpluslist(String empno, String month) throws Exception {
		Map<String, Object> user = new HashMap<>();
		user.put("empno", empno);
		user.put("month", month);
		return sqlsession.selectList(namespace + ".getgtwpluslist", user);
	}

}
