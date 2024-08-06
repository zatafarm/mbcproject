package com.mbc.academy.code;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class CodeDTO {
	private String CODENUM;
	private String CODESE;
	private String CODENM;
	private String USEYN;
}
