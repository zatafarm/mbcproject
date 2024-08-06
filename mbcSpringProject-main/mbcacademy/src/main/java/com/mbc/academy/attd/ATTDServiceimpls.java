package com.mbc.academy.attd;

import java.time.LocalDate;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ATTDServiceimpls implements ATTDService {

	@Autowired
	private ATTDDAO attdDAO;

	@Override
	public int gettoday(LocalDate today) throws Exception {
		return attdDAO.gettoday(today);
	}

	@Override
	public List<AttdDTO> getallempno() throws Exception {
		return attdDAO.getallempno();
	}

	@Override
	public void inserttoday(String empno) throws Exception {
		attdDAO.inserttoday(empno);
	}

	@Override
	public void allinserttoday(List<AttdDTO> attdempno) throws Exception {
		attdDAO.allinserttoday(attdempno);
	}

	@Override
	public void gtw(String empno) throws Exception {
		attdDAO.gtw(empno);
	}

	@Override
	public String gtwselectone(String empno) throws Exception {
		return attdDAO.gtwselectone(empno);
	}

	@Override
	public void settimest(String sttime) throws Exception {
		attdDAO.settimest(sttime);

	}

	@Override
	public void settimeen(String entime) throws Exception {
		attdDAO.settimeen(entime);
	}

	@Override
	public int gow(String empno) throws Exception {
		return attdDAO.gow(empno);

	}

	@Override
	public List<AttdDTO> gtwlist(String empno) throws Exception {
		return attdDAO.gtwlist(empno);

	}

	@Override
	public List<AttdDTO> gtwpluslist(String empno, String month) throws Exception {
		return attdDAO.gtwpluslist(empno, month);
	}
}
