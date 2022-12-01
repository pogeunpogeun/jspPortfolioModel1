package memo.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import config.DB;
import memo.model.dto.MemoDTO;

public class MemoDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public ArrayList<MemoDTO> getSelectAll(String searchGubun, String searchData) {
		ArrayList<MemoDTO> list = new ArrayList<>();
		conn = DB.dbConn();
		try {
			String sql = "select * from memo where 1 = 1 ";
			if(searchGubun.equals("name")) {
				sql += " and name like ? ";
			} else if(searchGubun.equals("content")) {
				sql += " and content like ? ";
			} else if(searchGubun.equals("name_content")) {
				sql += " and (name like ? or content like ?)";
			}
			sql += "order by no desc";
			
			pstmt = conn.prepareStatement(sql);
			
			if(searchGubun.equals("name")) {
				pstmt.setString(1, '%' + searchData + '%');
			} else if(searchGubun.equals("content")) {
				pstmt.setString(1, '%' + searchData + '%');
			} else if(searchGubun.equals("name_content")) {
				pstmt.setString(1, '%' + searchData + '%');
				pstmt.setString(2, '%' + searchData + '%');
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemoDTO resultDto = new MemoDTO();
				resultDto.setNo(rs.getInt("no"));
				resultDto.setWriter(rs.getString("writer"));
				resultDto.setContent(rs.getString("content"));
				resultDto.setRegiDate(rs.getDate("regiDate"));
				resultDto.setAttachInfo(rs.getString("attachInfo"));
				list.add(resultDto);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return list;
	}
	public MemoDTO getSelectOne(MemoDTO paramDto) {
		MemoDTO resultDto = new MemoDTO();
		conn = DB.dbConn();
		try {
			String sql = "select * from memo where no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getNo());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				resultDto.setNo(rs.getInt("no"));
				resultDto.setWriter(rs.getString("writer"));
				resultDto.setContent(rs.getString("content"));
				resultDto.setRegiDate(rs.getDate("regiDate"));
				resultDto.setAttachInfo(rs.getString("attachInfo"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return resultDto;
	}
	public int setInsert(MemoDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "insert into memo values (seq_memo.nextval,?,?,sysdate,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paramDto.getWriter());
			pstmt.setString(2, paramDto.getContent());
			pstmt.setString(3, paramDto.getAttachInfo());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
		
	}
	public int setUpdate(MemoDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "update memo set content=? where no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paramDto.getContent());
			pstmt.setInt(2, paramDto.getNo());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	public int setDelete(MemoDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "delete memo where no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getNo());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}


}
