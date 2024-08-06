package com.mbc.academy.cmt;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CmtDAOImple implements CmtDAO {

    @Autowired
    private SqlSession sqlsession;
    private static final String namespace = "com.mbc.academy.mapper.cmtMapper";
    
    @Override
    public List<CmtDTO> cmtList1(int bno) throws Exception {
        return sqlsession.selectList(namespace + ".cmtList1", bno);
    }

    @Override
    public  List<CmtDTO> cmtList2(List<CmtDTO> cnolist) throws Exception {
    	List<CmtDTO> cmtAlllist = new ArrayList<CmtDTO>();
    	for(int a=0; a<cnolist.size(); a++) {
    	int cno = cnolist.get(a).getCno1();
    	int cnocount = sqlsession.selectOne(namespace + ".countcno1" , cno);
    	for(int b=0; b<cnocount; b++) {
    	Map<String, Object> selectcno  = new HashMap<>();
    	selectcno.put("selectcmt", b);
    	selectcno.put("cno1", cno);
        CmtDTO dto = sqlsession.selectOne(namespace + ".cmtList2", selectcno);
        cmtAlllist.add(dto);
    	}
    	}
    	return cmtAlllist;
    }

    @Override
    public int cmtRegister1(CmtDTO dto) throws Exception {
        int result = sqlsession.insert(namespace + ".cmtRegister1", dto);
        if(result > 0) {
            System.out.println(dto.getEmpno() + " DAO : 댓글 등록 성공");
        } else {
            System.out.println(dto.getEmpno() + " DAO : 댓글 등록 실패");
        }
        return result;
    }

    @Override
    public int cmtRegister2(CmtDTO dto) throws Exception {
        int result = sqlsession.insert(namespace + ".cmtRegister2", dto);
        if(result > 0) {
            System.out.println(dto.getEmpno() + " DAO : 대댓글 등록 성공");
        } else {
            System.out.println(dto.getEmpno() + " DAO : 대댓글 등록 실패");
        }
        return result;
    }

    @Override
    public int cmtUpdate1(CmtDTO dto) throws Exception {
        int result = sqlsession.update(namespace + ".cmtUpdate1", dto);
        if(result > 0) {
            System.out.println(dto.getCno1() + " 번 DAO : 댓글 수정 성공");
        } else {
            System.out.println(dto.getCno1() + " 번 DAO : 댓글 수정 실패");
        }
        return result;
    }

    @Override
    public int cmtUpdate2(CmtDTO dto) throws Exception {
        int result = sqlsession.update(namespace + ".cmtUpdate2", dto);
        if(result > 0) {
            System.out.println(dto.getCno2() + " 번 DAO : 대댓글 수정 성공");
        } else {
            System.out.println(dto.getCno2() + " 번 DAO : 대댓글 수정 실패");
        }
        return result;
    }

    @Override
    public int delc1(int bno) throws Exception {
        int result = sqlsession.update(namespace + ".delc1", bno);
        if(result > 0) {
            System.out.println(bno + "번 Service: 댓글 삭제 성공");
        } else {
            System.out.println(bno + "번 Service: 댓글 삭제 실패");
        }
        return result;
    }

    @Override
    public int delc2(int cno1) throws Exception {
        int result = sqlsession.update(namespace + ".delc2", cno1);
        if(result > 0) {
            System.out.println(cno1 + "번 Service: 대댓글 삭제 성공");
        } else {
            System.out.println(cno1 + "번 Service: 대댓글 삭제 실패");
        }
        return result;
    }



	@Override
	public String getpostempno(int bno) throws Exception {
		String target = sqlsession.selectOne(namespace + ".getpostempno", bno);
		return target;
	}

	@Override
	public List<CmtDTO> cnoList(int bno) throws Exception {
		return sqlsession.selectList(namespace + ".cnolist", bno);
	}
}