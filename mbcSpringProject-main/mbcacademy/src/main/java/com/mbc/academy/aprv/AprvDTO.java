package com.mbc.academy.aprv;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AprvDTO {
	private int pno;
	private String empno;
	private String dept;
	private Double usp;
	private String strdt;
	private String endt;
	private String ptotp;
	private String ptorea;
	private String reqdt;
	private String stts;
	private String apprver;
	private String rjctnrea;
	private String apprvldt;
	private String codenm;
	private String reqnm;
	private String aprvnm;
	private String ptotpnm;
	private String sttsnm;
	private String deptnm;
	private Double pto;
	private Double addpto;
	private Double usdpto;
	private Double halfpto;
	private Double totalpto;
	private Double rstpto;
	private String atst;
}