package com.mbc.academy.chnemp;

import com.mbc.academy.Criteria;

public class ChnempCriteria extends Criteria {
	private int sesAdmns;
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

	public ChnempCriteria() {
		super();
	}

	public int getSesAdmns() {
		return sesAdmns;
	}

	public void setSesAdmns(int admns) {
		this.sesAdmns = admns;
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
		if (searchField.equals("reqnm")) {
			this.resultSearchField = "신청자 : ";
			this.resultKeyword = keyword;
			this.resultKeyword2 = "";
		} else if (searchField.equals("whochnnm")) {
			this.resultSearchField = "변경 대상자 : ";
			this.resultKeyword = keyword;
			this.resultKeyword2 = "";
		} else if (searchField.equals("typchn")) {
			if (keyword.equals("0")) {
				this.resultKeyword = "정보변경";
			} else if (keyword.equals("1")) {
				this.resultKeyword = "퇴사";
			} else {
				this.resultKeyword = "";
			}
			this.resultSearchField = "변경 종류 : ";
			this.resultKeyword2 = "";
		} else if (searchField.equals("reqdt")) {
			this.resultSearchField = "신청일 : ";
			this.resultKeyword = keyword;
			this.resultKeyword2 = " ~ " + keyword2;
		} else if (searchField.equals("resdt")) {
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
		return "AprvCriteria [sesAdmns=" + sesAdmns + ", sesEmpno=" + sesEmpno
				+ ", searchField=" + searchField + ", keyword=" + keyword + ", keyword2=" + keyword2 + ", column="
				+ column + ", sortOrder=" + sortOrder + ", resultSearchField=" + resultSearchField + ", resultKeyword="
				+ resultKeyword + ", resultKeyword2=" + resultKeyword2 + ", resultSearch=" + resultSearch
				+ "toString()=" + super.toString() + "]";
	}

}