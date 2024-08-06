package com.mbc.academy.file;

import java.util.List;

public interface FileDAO {
	public void saveAll(List<FileRequest> files);
	public List<FileResponse> findAllFileByPostId(int bno);
	public void deleteAllFileByIds(final List<Integer> ids);
	public List<FileResponse> findAllFileByIds(List<Integer> ids);
	public FileResponse findFileById(int id);
	public FileResponse findimg(int bno, String originalName);
}
