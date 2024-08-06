package com.mbc.academy;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.mbc.academy.board.MbcDAO;
import com.mbc.academy.board.MbcDTO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "file:src/main/webapp/WEB-INF/spring/root-context.xml" })
public class BoardInsertTest {
	@Inject
	private MbcDAO dao;
	
	@Test
	public void testRegister() throws Exception {
		MbcDTO dto = new MbcDTO();
		System.out.println("게시판 등록 테스트 시도");
		for (int i = 1; i <= 200; i++) {
			dto.setTtl("게시글 등록 테스트");
			dto.setCnt("등록테스트입니다.");
			dto.setEmpno("2014001");
			dao.register(dto);
			System.out.println(i + " 번 등록완료");
		}
	}
}
