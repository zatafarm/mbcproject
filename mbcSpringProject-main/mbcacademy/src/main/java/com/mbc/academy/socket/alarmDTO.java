package com.mbc.academy.socket;

import java.sql.Date;
import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class alarmDTO {
	private String content;
	private String prefixcontent;
	private String empno;
	private String adates;
	private LocalDateTime adate;
	private int bno;
	private int acheck;
	private String url;
}
