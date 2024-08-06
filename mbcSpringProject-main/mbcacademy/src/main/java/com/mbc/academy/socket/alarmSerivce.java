package com.mbc.academy.socket;

import java.util.List;
import java.util.Map;

public interface alarmSerivce {
public void insertalarm(Map<String, Object> messageDTO) throws Exception;
public List<alarmDTO> getalarmdb(String userId) throws Exception;
public int getcountalarm(String userId) throws Exception;
public void deletealarm(String alarmId) throws Exception;
}
