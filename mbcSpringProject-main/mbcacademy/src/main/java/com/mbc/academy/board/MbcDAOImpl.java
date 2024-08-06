package com.mbc.academy.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MbcDAOImpl implements MbcDAO {

	@Autowired
	private SqlSession sqlsession;
	private static final String namespace = "com.mbc.academy.mapper.boardmapper";

	//메인화면
	@Override
	public List<MbcDTO> getlist() throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.selectList(namespace + ".getlist" );
	}
	
	@Override
	public List<MbcDTO> listrprb() throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.selectList(namespace + ".listrprb" );
	}

	@Override
	public List<MbcDTO> getaumlist() throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.selectList(namespace + ".getaumlist" );
	}	
	
	// 사내게시판

	@Override
	public List<MbcDTO> list(MbcCriteria cri) throws Exception {
		System.out.println("list창 진입 DAO");
		return sqlsession.selectList(namespace + ".list", cri);
	}

	@Override
	public int getTotalCountBoard(MbcCriteria cri) throws Exception {
		return sqlsession.selectOne(namespace + ".getTotalCountBoard", cri);
	}

	@Override
	public List<MbcDTO> mylist(MbcCriteria cri) throws Exception {
		System.out.println("list창 진입 DAO");
		return sqlsession.selectList(namespace + ".mylist", cri);
	}

	@Override
	public int getTotalCountMyBoard(MbcCriteria cri) throws Exception {
		return sqlsession.selectOne(namespace + ".getTotalCountMyBoard", cri);
	}

	@Override
	public int updateReadCnt(int bno) throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.update(namespace + ".updateReadCnt", bno);
	}

	@Override
	public int update(MbcDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.update(namespace + ".update", dto);
	}

	@Override
	public int register(MbcDTO dto) throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.insert(namespace + ".register", dto);
	}

	@Override
	public int delete(int bno) throws Exception {
		return sqlsession.update(namespace + ".delete", bno);
	}

	@Override
	public int admnDelete(int bno, String delrea) throws Exception {
		Map<String, Object> params = new HashMap<>();
		params.put("bno", bno);
		params.put("delrea", delrea);
		return sqlsession.update(namespace + ".admnDelete", params);
	}

	@Override
	public MbcDTO detail(int bno) throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.selectOne(namespace + ".detail", bno);
	}

	// 공지사항

	@Override
	public List<MbcDTO> aumlist(MbcCriteria cri) throws Exception {
		// TODO Auto-generated method stub
		return sqlsession.selectList(namespace + ".aumlist", cri);
	}

	@Override
	public int getTotalAum(MbcCriteria cri) throws Exception {
		return sqlsession.selectOne(namespace + ".getTotalAum", cri);
	}

	@Override
	public int updateRprb(int bno) throws Exception {
		return sqlsession.update(namespace + ".updateRprb", bno);
	}

}
