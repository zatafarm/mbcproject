package com.mbc.academy.file;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FileServiceimpls implements FileService {
	@Autowired
    FileDAO fileMapper;
    
    @Override
    @Transactional
    public void saveFiles(final int bno, final List<FileRequest> files) throws Exception {
        if (CollectionUtils.isEmpty(files)) {
            return;
        }
        for (FileRequest file : files) {
            file.setBno(bno);
        }
        fileMapper.saveAll(files);
    }


    @Override
    public List<FileResponse> findAllFileByPostId(final int bno) {
        return fileMapper.findAllFileByPostId(bno);
    }
    @Override
	public List<FileResponse> findAllFileByIds(final List<Integer> ids) {
        if (CollectionUtils.isEmpty(ids)) {
            return Collections.emptyList();
        }
        return fileMapper.findAllFileByIds(ids);
    }

	@Override
    @Transactional
    public void deleteAllFileByIds(final List<Integer> ids) {
        if (CollectionUtils.isEmpty(ids)) {
            return;
        }
        fileMapper.deleteAllFileByIds(ids);
    }
	@Override
    public FileResponse findFileById(final int id) {
        return fileMapper.findFileById(id);
    }


	@Override
	public FileResponse findimg(int bno, String originalName) {
		return fileMapper.findimg(bno, originalName);
		
}
}