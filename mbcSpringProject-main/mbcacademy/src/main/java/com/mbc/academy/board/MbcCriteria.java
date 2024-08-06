package com.mbc.academy.board;

import com.mbc.academy.Criteria;

public class MbcCriteria extends Criteria {
	private String sesEmpno;
	private String searchSelect;
	private String keyword;
	private String resultSearchSelect;
	private String resultKeyword;
	private String resultSearch;

	public MbcCriteria() {
		super();
	}

	public String getSesEmpno() {
		return sesEmpno;
	}

	public void setSesEmpno(String sesEmpno) {
		this.sesEmpno = sesEmpno;
	}

	public String getSearchSelect() {
		return searchSelect;
	}

	public void setSearchSelect(String searchSelect) {
		this.searchSelect = searchSelect;
		if (searchSelect.equals("ttl")) {
			this.resultSearchSelect = "제목 : ";
			this.resultKeyword = keyword;
		} else if(searchSelect.equals("cnt")) {
			this.resultSearchSelect = "내용 : ";
			this.resultKeyword = keyword;
		} else if(searchSelect.equals("ename")) {
			this.resultSearchSelect = "작성자 : ";
			this.resultKeyword = keyword;
		} else {
			this.resultSearchSelect = "";
			this.resultKeyword = "";
		}
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public String getResultSearchSelect() {
		return resultSearchSelect;
	}

	public void setResultSearchSelect(String resultSearchSelect) {
		this.resultSearchSelect = resultSearchSelect;
	}

	public String getResultKeyword() {
		return resultKeyword;
	}

	public void setResultKeyword(String resultKeyword) {
		this.resultKeyword = resultKeyword;
	}

	public String getResultSearch() {
		if (resultKeyword != null) {
			resultSearch = resultSearchSelect + resultKeyword;
		}
		return resultSearch;
	}

	public void setResultSearch(String resultSearch) {
		this.resultSearch = resultSearch;
	}

	@Override
	public String toString() {
		return "MbcCriteria [sesEmpno=" + sesEmpno + ", searchSelect=" + searchSelect + ", keyword=" + keyword
				+ ", resultSearchSelect=" + resultSearchSelect + ", resultKeyword=" + resultKeyword + ", resultSearch="
				+ resultSearch + ", toString()=" + super.toString() + "]";
	}

}
