package com.mbc.academy.attd;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class AttdDTO {
	private String EMPNO;
	private String ATTDT;
	private String STRTM;
	private String ATST;
	private String ENTM;
	private String codese;
	private String codenum;
	private String codenm;
}
