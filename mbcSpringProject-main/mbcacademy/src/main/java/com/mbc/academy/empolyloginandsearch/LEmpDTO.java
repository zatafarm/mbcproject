package com.mbc.academy.empolyloginandsearch;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class LEmpDTO {
	private String empno;
	private String ename;
	private String pwd;
	private String bri;
	private String tel;
	private String ctel;
	private String ctelf;
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
	private int cump;
	private int cuma;
	@Builder.Default
	private String adr1 = "";
	@Builder.Default
	private String adr2 = "";
	@Builder.Default
	private String adr3 = "";

	public String Adrdivide() {
		boolean searchcm = false;
		int commadigit = 0;
		while (!searchcm && commadigit < adr.length()) {
			char a = adr.charAt(commadigit);
			if (a == ',') {
				this.adr1 = adr.substring(0, commadigit);
				int commadigit2 = commadigit + 1;
				while (commadigit2 < adr.length()) {
					char b = adr.charAt(commadigit2);
					if (b == '(') {
						this.adr2 = adr.substring(commadigit + 1, commadigit2);
						this.adr3 = adr.substring(commadigit2).trim();
						searchcm = true;
						break;
					}
					commadigit2 += 1;
				}
			}
			commadigit += 1;
		}

		if (!searchcm) {
			this.adr1 = this.adr;
			this.adr2 = "";
			adr3 = "";
		}
		System.out.println(adr1);
		System.out.println(adr2);
		System.out.println(adr3);
		return adr1 + adr2 + adr3;
	}

	public void setSal(int sal) {
		this.sal = sal;
		this.fmtSal = String.format("%,d", sal);
	}

	public String getCtelf() {
		return "031" + "-" + "000" + "-" + ctel;
	}

	public String getCmail() {
		return this.empno + "@mbcacademy.com";
	}

	public String getPstn() {
		if (pstn == 0) {
			return "총책임자";
		} else if (pstn == 1) {
			return "팀장";
		} else if (pstn == 2) {
			return "팀원";
		}
		return null;
	}

}