package com.mbc.academy.socket;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class alarmDAOimpls implements alarmDAO {

	@Autowired
	private SqlSession sqlsession;
	
	private static final String namespace = "com.mbc.academy.alarm";

	@Override
	public void insertalarm(Map<String, Object> messageDTO) {
		sqlsession.insert(namespace + ".insertalarm", messageDTO);	
	}

	@Override
	public List<alarmDTO> getalarmdb(String userId) throws Exception {
		return sqlsession.selectList(namespace + ".getalarmlist", userId);
	}
	
	@Override
	public int getcountalarm(String userId) throws Exception {
		return sqlsession.selectOne(namespace + ".countalarmlist", userId);
	}
	@Override
	public void deletealarm(String alarmId) throws Exception {
		sqlsession.delete(namespace + ".deletealarm", alarmId);
	}
}
