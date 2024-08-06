package com.mbc.academy.cmt;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class CmtServiceImple implements CmtService {

    @Autowired
    CmtDAO dao;
    
    @Override
    public List<CmtDTO> cmtList1(int bno) throws Exception {
        System.out.println("cmt창 진입 Service");
        return dao.cmtList1(bno);
    }

    @Override
    public  List<CmtDTO> cmtList2(List<CmtDTO> cnolist) throws Exception {
    	System.out.println("대댓글 cmt창 진입 Service");
        return dao.cmtList2(cnolist);
    }

    @Override
    public int cmtRegister1(CmtDTO dto) throws Exception {
        int result = dao.cmtRegister1(dto);
        if(result > 0) {
            System.out.println(dto.getEmpno() + " Service : 댓글 등록 성공");
        } else {
            System.out.println(dto.getEmpno() + " Service : 댓글 등록 실패");
        }
        return result;
    }

    @Override
    public int cmtRegister2(CmtDTO dto) throws Exception {
        int result = dao.cmtRegister2(dto);
        if(result > 0) {
            System.out.println(dto.getEmpno() + " Service : 대댓글 등록 성공");
        } else {
            System.out.println(dto.getEmpno() + " Service : 대댓글 등록 실패");
        }
        return result;
    }

    @Override
    public int cmtUpdate1(CmtDTO dto) throws Exception {
        int result = dao.cmtUpdate1(dto);
        if(result > 0) {
            System.out.println(dto.getCno1() + " 번 Service : 댓글 수정 성공");
        } else {
            System.out.println(dto.getCno1() + " 번 Service : 댓글 수정 실패");
        }
        return result;
    }

    @Override
    public int cmtUpdate2(CmtDTO dto) throws Exception {
        int result = dao.cmtUpdate2(dto);
        if(result > 0) {
            System.out.println(dto.getCno2() + " 번 Service : 대댓글 수정 성공");
        } else {
            System.out.println(dto.getCno2() + " 번 Service : 대댓글 수정 실패");
        }
        return result;
    }

    @Override
    public int delc1(int bno) throws Exception {
        int result = dao.delc1(bno);
        if(result > 0) {
            System.out.println(bno + "번 Service: 댓글 삭제 성공");
        } else {
            System.out.println(bno + "번 Service: 댓글 삭제 실패");
        }
        return result;
    }

    @Override
    public int delc2(int cno1) throws Exception {
        int result = dao.delc2(cno1);
        if(result > 0) {
            System.out.println(cno1 + "번 Service: 대댓글 삭제 성공");
        } else {
            System.out.println(cno1 + "번 Service: 대댓글 삭제 실패");
        }
        return result;
    }

	@Override
	public String getpostempno(int bno) throws Exception {
		return dao.getpostempno(bno);
	}

	@Override
	public List<CmtDTO> cnoList(int bno) throws Exception {
		// TODO Auto-generated method stub
		return dao.cnoList(bno);
	}
}
