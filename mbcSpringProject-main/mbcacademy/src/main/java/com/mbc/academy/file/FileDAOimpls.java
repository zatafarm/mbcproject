package com.mbc.academy.file;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class FileDAOimpls implements FileDAO {
	@Autowired
	private SqlSession sqlsession;
	private static final String namespace = "com.mbc.academy.file.FileMapper";

	
	@Override
	public void saveAll(List<FileRequest> files) {
			sqlsession.selectList(namespace + ".saveAll" , files);
	}


	@Override
	public List<FileResponse> findAllFileByPostId(int bno) {
	
		return sqlsession.selectList(namespace + ".findAllByPostId" , bno);
	}


	@Override
	public void deleteAllFileByIds(List<Integer> ids) {
	
		sqlsession.selectList(namespace + ".deleteAllByIds" , ids);
	}


	@Override
	public List<FileResponse> findAllFileByIds(List<Integer> ids) {
	
		return sqlsession.selectList(namespace + ".findAllByIds" , ids);
	}


	@Override
	public FileResponse findFileById(int id) {
		return sqlsession.selectOne(namespace + ".findById" , id);
	}


	@Override
	public FileResponse findimg(int bno, String originalName) {
	    Map<String, Object> img = new HashMap<>();
	    img.put("bno", bno);
	    img.put("ori", originalName);
		return sqlsession.selectOne(namespace + ".findimg" , img);
	}




}
