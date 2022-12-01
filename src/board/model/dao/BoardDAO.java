package board.model.dao;

import java.util.ArrayList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import board.model.dto.BoardDTO;
import config.DB;

public class BoardDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public ArrayList<BoardDTO> getSelectAll(String searchGubun, String searchData, int startRecord, int lastRecord) {
		String searchValue = "O";
		if (searchGubun == null || searchGubun.trim().equals("")) { searchGubun = ""; }
		if (searchData == null || searchData.trim().equals("")) { searchData = ""; }
		if (searchGubun.equals("") || searchData.trim().equals("")) {
			searchValue = "X";
			searchGubun = "";
			searchData = "";
		}
		
		ArrayList<BoardDTO> list = new ArrayList<>();
		conn = DB.dbConn();
		try {
			String basicSql = "";
			basicSql += "select * from board ";
			if (searchValue.equals("O")) {
				if (searchGubun.equals("writer_subject_content")) {
					basicSql += "where (writer like ? or subject like ? or content like ?) ";
				} else {
					basicSql += "where " + searchGubun + " like ? ";
				}
			}
			basicSql += "order by noticeNo desc, refNo desc, levelNo asc";
		
			String sql = "";
			sql += "select * from (select A.*, Rownum rnum from (";
			sql += basicSql;
			sql += ") A) where rnum >= ? and rnum <= ?";
			
			pstmt = conn.prepareStatement(sql);
			
			if (searchValue.equals("O")) {
				if (searchGubun.equals("writer_subject_content")) {
					pstmt.setString(1, '%' + searchData + '%');
					pstmt.setString(2, '%' + searchData + '%');
					pstmt.setString(3, '%' + searchData + '%');
					pstmt.setInt(4, startRecord);
					pstmt.setInt(5, lastRecord);
				} else {
					pstmt.setString(1, '%' + searchData + '%');
					pstmt.setInt(2, startRecord);
					pstmt.setInt(3, lastRecord);
				}
			} else {
				pstmt.setInt(1, startRecord);
				pstmt.setInt(2, lastRecord);
			}

			
			

			
			
			
			
			rs = pstmt.executeQuery();
			while (rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setNo(rs.getInt("no"));
				dto.setNum(rs.getInt("num"));
				dto.setTbl(rs.getString("tbl"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setEmail(rs.getString("email"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setRefNo(rs.getInt("refNo"));
				dto.setStepNo(rs.getInt("stepNo"));
				dto.setLevelNo(rs.getInt("levelNo"));
				dto.setParentNo(rs.getInt("parentNo"));
				dto.setHit(rs.getInt("hit"));
				dto.setIp(rs.getString("ip"));
				dto.setMemberNo(rs.getInt("memberNo"));
				dto.setNoticeNo(rs.getInt("noticeNo"));
				dto.setSecretGubun(rs.getString("secretGubun"));
				dto.setRegiDate(rs.getDate("regiDate"));
				dto.setAttachInfo(rs.getString("attachInfo"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return list;
	}
	
	public BoardDTO getSelectOne(BoardDTO paramDto) {
		BoardDTO dto = new BoardDTO();
		conn = DB.dbConn();
		try {
			String sql = "select * from board where no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getNo());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setNo(rs.getInt("no"));
				dto.setNum(rs.getInt("num"));
				dto.setTbl(rs.getString("tbl"));
				dto.setWriter(rs.getString("writer"));
				dto.setSubject(rs.getString("subject"));
				dto.setContent(rs.getString("content"));
				dto.setEmail(rs.getString("email"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setRefNo(rs.getInt("refNo"));
				dto.setStepNo(rs.getInt("stepNo"));
				dto.setLevelNo(rs.getInt("levelNo"));
				dto.setParentNo(rs.getInt("parentNo"));
				dto.setHit(rs.getInt("hit"));
				dto.setIp(rs.getString("ip"));
				dto.setMemberNo(rs.getInt("memberNo"));
				dto.setNoticeNo(rs.getInt("noticeNo"));
				dto.setSecretGubun(rs.getString("secretGubun"));
				dto.setRegiDate(rs.getDate("regiDate"));
				dto.setAttachInfo(rs.getString("attachInfo"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return dto;
	}

	public int setInsert(BoardDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "insert into board values (seq_board.nextval,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, sysdate, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getNum());
			pstmt.setString(2, paramDto.getTbl());
			pstmt.setString(3, paramDto.getWriter());
			pstmt.setString(4, paramDto.getSubject());
			pstmt.setString(5, paramDto.getContent());
			pstmt.setString(6, paramDto.getEmail());
			pstmt.setString(7, paramDto.getPasswd());
			pstmt.setInt(8, paramDto.getRefNo());
			pstmt.setInt(9, paramDto.getStepNo());
			pstmt.setInt(10, paramDto.getLevelNo());
			pstmt.setInt(11, paramDto.getParentNo());
			pstmt.setInt(12, paramDto.getHit());
			pstmt.setString(13, paramDto.getIp());
			pstmt.setInt(14, paramDto.getMemberNo());
			pstmt.setInt(15, paramDto.getNoticeNo());
			pstmt.setString(16, paramDto.getSecretGubun());
			pstmt.setString(17, paramDto.getAttachInfo());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}

	public int setUpdate(BoardDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "";
			sql += "update board set ";
			sql += "subject = ?, ";
			sql += "content = ?, ";
			sql += "email = ?, ";
			sql += "noticeNo = ?, ";
			sql += "secretGubun = ?, ";
			sql += "attachInfo = ? ";
			sql += "where no = ? and passwd = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paramDto.getSubject());
			pstmt.setString(2, paramDto.getContent());
			pstmt.setString(3, paramDto.getEmail());
			pstmt.setInt(4, paramDto.getNoticeNo());
			pstmt.setString(5, paramDto.getSecretGubun());
			pstmt.setString(6, paramDto.getAttachInfo());
			pstmt.setInt(7, paramDto.getNo());
			pstmt.setString(8, paramDto.getPasswd());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	
	public int setDelete(BoardDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "delete from board where no = ? and passwd = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getNo());
			pstmt.setString(2, paramDto.getPasswd());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	
	
	
	
	public int getTotalRecord(String searchGubun, String searchData) {
		String searchValue = "O";
		if (searchGubun == null || searchGubun.trim().equals("")) { searchGubun = ""; }
		if (searchData == null || searchData.trim().equals("")) { searchData = ""; }
		if (searchGubun.equals("") || searchData.trim().equals("")) {
			searchValue = "X";
			searchGubun = "";
			searchData = "";
		}
		
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = ""; //"select count(*) recordCounter from board";

			if (searchValue.equals("X")) {
				sql = "select count(*) recordCounter from board";
			} else {
				if (searchGubun.equals("writer_subject_content")) {
					sql = "select count(*) recordCounter from board where (writer like ? or subject like ? or content like ?)";
				} else {
					sql = "select count(*) recordCounter from board where " + searchGubun + " like ?";
				}
			}

			pstmt = conn.prepareStatement(sql);
			
			if (searchValue.equals("X")) {
				
			} else {
				if (searchGubun.equals("writer_subject_content")) {
					pstmt.setString(1, '%' + searchData + '%');
					pstmt.setString(2, '%' + searchData + '%');
					pstmt.setString(3, '%' + searchData + '%');
				} else {
					pstmt.setString(1, '%' + searchData + '%');
				}
			}
			
			
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt("recordCounter");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	
	
	
	public int getMaxNumRefNo(String gubun) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "select nvl(max(" + gubun + "), 0) maxValue from board";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt("maxValue");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	
	public void setUpdateRelevel(BoardDTO paramDto) {
		conn = DB.dbConn();
		try {
			String sql = "update board set levelNo = (levelNo + 1) where refNo = ? and levelNo > ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getRefNo());
			pstmt.setInt(2, paramDto.getLevelNo());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}	
	}

	public void setUpdateHit(BoardDTO paramDto) {
		conn = DB.dbConn();
		try {
			String sql = "update board set hit = (hit + 1) where no = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getNo());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}	
	}
	
}
