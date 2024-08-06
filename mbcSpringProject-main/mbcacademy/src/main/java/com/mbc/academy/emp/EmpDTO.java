package com.mbc.academy.emp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@Builder
@AllArgsConstructor
@NoArgsConstructor
public class EmpDTO {
	private String empno;
	private String ename;
	private String pwd;
	private String bri;
	private String tel;
	private String ctel;
	private String email;
	private String adr;
	private String hrdt;
	private String dept;
	private String ranks;
	private int pstn;
	private int sal;
	private String fmtSal;
	private int admns;
	private int rsg;
	private String rsgdt;
	private String codenm;
	private Double pto;
	private String pstnm;
	private String empPct;

	public String getEmpno() {
		return empno;
	}

	public void setEmpno(String empno) {
		this.empno = empno;
	}

	public String getEname() {
		return ename;
	}

	public void setEname(String ename) {
		this.ename = ename;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getBri() {
		return bri;
	}

	public void setBri(String bri) {
		this.bri = bri;
	}

	public String getTel() {
		return tel;
	}

	public void setTel(String tel) {
		this.tel = tel;
	}

	public String getCtel() {
		return ctel;
	}

	public void setCtel(String ctel) {
		this.ctel = ctel;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getAdr() {
		return adr;
	}

	public void setAdr(String adr) {
		this.adr = adr;
	}

	public String getHrdt() {
		return hrdt;
	}

	public void setHrdt(String hrdt) {
		this.hrdt = hrdt;
	}

	public String getDept() {
		return dept;
	}

	public void setDept(String dept) {
		this.dept = dept;
	}

	public String getRanks() {
		return ranks;
	}

	public void setRanks(String ranks) {
		this.ranks = ranks;
	}

	public int getPstn() {
		return pstn;
	}

	public void setPstn(int pstn) {
		this.pstn = pstn;
	}

	public int getSal() {
		return sal;
	}

	public void setSal(int sal) {
		this.sal = sal;
		this.fmtSal = String.format("%,d", sal);
	}

	public String getFmtSal() {
		return fmtSal;
	}

	public void setFmtSal(String fmtSal) {
		this.fmtSal = fmtSal;
	}

	public int getAdmns() {
		return admns;
	}

	public void setAdmns(int admns) {
		this.admns = admns;
	}

	public int getRsg() {
		return rsg;
	}

	public void setRsg(int rsg) {
		this.rsg = rsg;
	}

	public String getRsgdt() {
		return rsgdt;
	}

	public void setRsgdt(String rsgdt) {
		this.rsgdt = rsgdt;
	}

	public String getCodenm() {
		return codenm;
	}

	public void setCodenm(String codenm) {
		this.codenm = codenm;
	}

	public Double getPto() {
		return pto;
	}

	public void setPto(Double pto) {
		this.pto = pto;
	}

	public String getPstnm() {
		return pstnm;
	}

	public void setPstnm(String pstnm) {
		this.pstnm = pstnm;
	}

	public String getEmpPct() {
		return empPct;
	}

	public void setEmpPct(String empPct) {
		this.empPct = empPct;
	}

	@Override
	public String toString() {
		return "EmpDTO [empno=" + empno + ", ename=" + ename + ", pwd=" + pwd + ", bri=" + bri + ", tel=" + tel
				+ ", ctel=" + ctel + ", email=" + email + ", adr=" + adr + ", hrdt=" + hrdt + ", dept=" + dept
				+ ", ranks=" + ranks + ", pstn=" + pstn + ", sal=" + sal + ", fmtSal=" + fmtSal + ", admns=" + admns
				+ ", rsg=" + rsg + ", rsgdt=" + rsgdt + ", codenm=" + codenm + ", pto=" + pto + ", pstnm=" + pstnm
				+ ", empPct=" + empPct + "]";
	}

}
