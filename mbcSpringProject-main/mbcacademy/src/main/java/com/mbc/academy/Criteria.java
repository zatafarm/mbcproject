package com.mbc.academy;


public class Criteria {
	private int page;
	private int perPageNum;
	private int pageStart;

	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		if (page <= 0) {
			this.page = 1;
		} else {
			this.page = page;
		}
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int perPageNum) {
		if (perPageNum <= 0 || perPageNum > 100) {
			this.perPageNum = 10;
		} else {
			this.perPageNum = perPageNum;
		}
	}

	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}

	public void setPageStart(int pageStart) {
		this.pageStart = pageStart;
	}

	@Override
	public String toString() {
		return "Criteria [page=" + page + ", perPageNum=" + perPageNum + ", pageStart=" + pageStart + "]";
	}

}
