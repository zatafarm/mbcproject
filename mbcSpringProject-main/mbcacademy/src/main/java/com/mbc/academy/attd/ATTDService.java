package com.mbc.academy.attd;

import java.time.LocalDate;
import java.util.List;

public interface ATTDService {
	public int gettoday(LocalDate now) throws Exception;
	public List<AttdDTO> getallempno() throws Exception;
	public void allinserttoday(List<AttdDTO> attdempno) throws Exception;
	public void gtw(String empno) throws Exception;
	public void inserttoday(String empno) throws Exception;
	public String gtwselectone(String empno) throws Exception;
	public void settimest(String sttime) throws Exception;
	public void settimeen(String entime) throws Exception;
	public int gow(String empno) throws Exception;
	public List<AttdDTO> gtwpluslist(String empno, String month) throws Exception;
	public List<AttdDTO> gtwlist(String empno) throws Exception;
}
