package com.mbc.academy.aprv;

import com.mbc.academy.Criteria;

public class AprvCriteria extends Criteria {
	private int sesAdmns;
	private String sesDept;
	private String sesEmpno;
	private String searchField;
	private String keyword;
	private String keyword2;
	private String column;
	private String sortOrder;
	private String resultSearchField;
	private String resultKeyword;
	private String resultKeyword2;
	private String resultSearch;

	public AprvCriteria() {
		super();
	}

	public int getSesAdmns() {
		return sesAdmns;
	}

	public void setSesAdmns(int admns) {
		this.sesAdmns = admns;
	}

	public String getSesDept() {
		return sesDept;
	}

	public void setSesDept(String dept) {
		this.sesDept = dept;
	}

	public String getSesEmpno() {
		return sesEmpno;
	}

	public void setSesEmpno(String sesEmpno) {
		this.sesEmpno = sesEmpno;
	}

	public String getSearchField() {
		return searchField;
	}

	public void setSearchField(String searchField) {
		this.searchField = searchField;
		if (searchField.equals("stts")) {
			if (keyword.equals("P0")) {
				this.resultKeyword = "대기";
			} else if (keyword.equals("P1")) {
				this.resultKeyword = "1차승인";
			} else if (keyword.equals("P2")) {
				this.resultKeyword = "최종승인";
			} else if (keyword.equals("P3")) {
				this.resultKeyword = "반려";
			} else {
				this.resultKeyword = "";
			}
			this.resultSearchField = "결재 상태 : ";
			this.resultKeyword2 = "";
		} else if (searchField.equals("ptotp")) {
			if (keyword.equals("T0")) {
				this.resultKeyword = "연차";
			} else if (keyword.equals("T1")) {
				this.resultKeyword = "반차";
			} else if (keyword.equals("T2")) {
				this.resultKeyword = "기타";
			} else {
				this.resultKeyword = "";
			}
			this.resultSearchField = "연차 종류 : ";
			this.resultKeyword2 = "";
		} else if (searchField.equals("reqnm")) {
			this.resultSearchField = "신청자 : ";
			this.resultKeyword = keyword;
			this.resultKeyword2 = "";
		} else if (searchField.equals("aprvnm")) {
			this.resultSearchField = "결재자 : ";
			this.resultKeyword = keyword;
			this.resultKeyword2 = "";
		} else if (searchField.equals("reqdt")) {
			this.resultSearchField = "신청일 : ";
			this.resultKeyword = keyword;
			this.resultKeyword2 = " ~ " + keyword2;
		} else if (searchField.equals("apprvldt")) {
			this.resultSearchField = "결재일 : ";
			this.resultKeyword = keyword;
			this.resultKeyword2 = " ~ " + keyword2;
		} else {
			this.resultSearchField = "";
			this.resultKeyword = "";
			this.resultKeyword2 = "";
		}
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getKeyword2() {
		return keyword2;
	}

	public void setKeyword2(String keyword2) {
		this.keyword2 = keyword2;
	}

	public String getColumn() {
		return column;
	}

	public void setColumn(String column) {
		this.column = column;
	}

	public String getSortOrder() {
		return sortOrder;
	}

	public void setSortOrder(String sortOrder) {
		this.sortOrder = sortOrder;
	}

	public String getResultSearchField() {
		return resultSearchField;
	}

	public void setResultSearchField(String resultSearchField) {
		this.resultSearchField = resultSearchField;
	}

	public String getResultKeyword() {
		return resultKeyword;
	}

	public void setResultKeyword(String resultKeyword) {
		this.resultKeyword = resultKeyword;
	}

	public String getResultKeyword2() {
		return resultKeyword2;
	}

	public void setResultKeyword2(String resultKeyword2) {
		this.resultKeyword2 = resultKeyword2;
	}

	public String getResultSearch() {
		if (resultKeyword != null) {
			resultSearch = resultSearchField + resultKeyword + resultKeyword2;
		}
		return resultSearch;
	}

	public void setResultSearch(String resultSearch) {
		this.resultSearch = resultSearch;
	}

	@Override
	public String toString() {
		return "AprvCriteria [sesAdmns=" + sesAdmns + ", sesDept=" + sesDept + ", sesEmpno=" + sesEmpno
				+ ", searchField=" + searchField + ", keyword=" + keyword + ", keyword2=" + keyword2 + ", column="
				+ column + ", sortOrder=" + sortOrder + ", resultSearchField=" + resultSearchField + ", resultKeyword="
				+ resultKeyword + ", resultKeyword2=" + resultKeyword2 + ", resultSearch=" + resultSearch
				+ "toString()=" + super.toString() + "]";
	}

}