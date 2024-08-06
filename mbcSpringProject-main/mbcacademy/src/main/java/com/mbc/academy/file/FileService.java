package com.mbc.academy.file;

import java.util.List;

import org.springframework.stereotype.Service;

@Service
public interface FileService {

	public void saveFiles(int bno, List<FileRequest> files) throws Exception;
	public List<FileResponse> findAllFileByPostId(int bno);
	public void deleteAllFileByIds(final List<Integer> ids);
	public FileResponse findimg(int bno, String originalName);
	public List<FileResponse> findAllFileByIds(List<Integer> ids);
	public FileResponse findFileById(int id);
}
