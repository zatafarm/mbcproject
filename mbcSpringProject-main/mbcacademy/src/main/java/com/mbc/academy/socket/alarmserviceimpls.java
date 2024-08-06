package com.mbc.academy.socket;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class alarmserviceimpls implements alarmSerivce {
	
	@Autowired
	alarmDAO alarmDAO;

	@Override
	public void insertalarm(Map<String, Object> messageDTO) throws Exception {
		alarmDAO.insertalarm(messageDTO);
	}

	@Override
	public List<alarmDTO> getalarmdb(String userId) throws Exception {
		return alarmDAO.getalarmdb(userId);
	}

	@Override
	public int getcountalarm(String userId) throws Exception {
		return alarmDAO.getcountalarm(userId);
	}
	@Override
	public void deletealarm(String alarmId) throws Exception{
		alarmDAO.deletealarm(alarmId);
	}
}
