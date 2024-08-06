package com.mbc.academy.file;


import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class FileApiController {
	
	@Autowired
    private final FileService fileService;
	@Autowired
	private final FileUtils fileUtils;
    // 파일 리스트 조회
	@GetMapping("/api/detail")
    public List<FileResponse> findAllFileByPostId(@RequestParam("bno") String bno) {
		int bno2 = Integer.parseInt(bno);
    	List<FileResponse> row = fileService.findAllFileByPostId(bno2);
        return row;
    }
	
	   @GetMapping("/detail/{bno}/files/{fileId}/download")
	    public ResponseEntity<Resource> downloadFile(@PathVariable final int bno, @PathVariable final int fileId) throws Exception{
	        FileResponse file = fileService.findFileById(fileId);
	        Resource resource = fileUtils.readFileAsResource(file);
	        try {
	            String filename = URLEncoder.encode(file.getOriginalName(), "UTF-8");
	            return ResponseEntity.ok()
	                    .contentType(MediaType.APPLICATION_OCTET_STREAM)
	                    .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; fileName=\"" + filename + "\";")
	                    .header(HttpHeaders.CONTENT_LENGTH, file.getSize() + "")
	                    .body(resource);

	        } catch (UnsupportedEncodingException e) {
	            throw new RuntimeException("filename encoding failed : " + file.getOriginalName());
	        }
	    }
}