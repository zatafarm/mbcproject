package com.mbc.academy.chnemp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ChnempDTO {
	private int chno;
	private String apl;
	private String whochn;
	private String empno;
	private String ename;
	private int typchn;
	private String chndept;
	private String predept;
	private int chnpstn;
	private int prepstn;
	private String reqdt;
	private int res;
	private String resdt;
	private String reqnm;
	private String reqdeptnm;
	private String chndeptnm;
	private String predeptnm;
	private String whochnnm;
}
