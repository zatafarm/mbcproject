package com.mbc.academy.file;

import lombok.Getter;


@Getter
public class FileResponse {

    private int id;                      // 파일 번호 (PK)
    private int bno;                  // 게시글 번호 (FK)
    private String originalName;          // 원본 파일명
    private String saveName;              // 저장 파일명
    private long size;                    // 파일 크기
    private Boolean deleteYn;             // 삭제 여부
    private String createdDate;    // 생성일시
    private String deletedDate;    // 삭제일시

}
