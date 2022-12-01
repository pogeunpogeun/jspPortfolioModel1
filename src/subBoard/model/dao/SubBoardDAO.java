package subBoard.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import config.DB;
import subBoard.model.dto.SubBoardCommentDTO;
import subBoard.model.dto.SubBoardDTO;

public class SubBoardDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	public int getTotalRecord(SubBoardDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "";
			sql += "select count(*) counter from board where tbl = ? ";
			
			if (paramDto.getSearchGubun().equals("writer_subject_content")) {
				sql += "and (writer like ? or subject like ? or content like ?) ";
			} else if (paramDto.getSearchGubun().equals("writer") || paramDto.getSearchGubun().equals("subject") || paramDto.getSearchGubun().equals("content")) {
				sql += "and " + paramDto.getSearchGubun() + " like ? ";
			} else {

			}

			pstmt = conn.prepareStatement(sql);
			
			int k = 0;
			pstmt.setString(++k, paramDto.getTbl());
			if (paramDto.getSearchGubun().equals("writer_subject_content")) {
				pstmt.setString(++k, '%' + paramDto.getSearchData() + '%');
				pstmt.setString(++k, '%' + paramDto.getSearchData() + '%');
				pstmt.setString(++k, '%' + paramDto.getSearchData() + '%');
			} else if (paramDto.getSearchGubun().equals("writer") || paramDto.getSearchGubun().equals("subject") || paramDto.getSearchGubun().equals("content")) {
				pstmt.setString(++k, '%' + paramDto.getSearchData() + '%');
			} else {

			}			
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt("counter");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	
	public ArrayList<SubBoardDTO> getSelectAll(SubBoardDTO paramDto) {
		ArrayList<SubBoardDTO> list = new ArrayList<>();
		conn = DB.dbConn();
		try {
			String basicSql = "";
			basicSql += "select * from board where tbl = ? ";
			
			if (paramDto.getSearchGubun().equals("writer_subject_content")) {
				basicSql += "and (writer like ? or subject like ? or content like ?) ";
			} else if (paramDto.getSearchGubun().equals("writer") || paramDto.getSearchGubun().equals("subject") || paramDto.getSearchGubun().equals("content")) {
				basicSql += "and " + paramDto.getSearchGubun() + " like ? ";
			} else {

			}
			
			basicSql += "order by noticeNo desc, refNo desc, levelNo asc";
			
			String sql = "";
			sql += "select * from (select A.*, Rownum rnum from (";
			sql += basicSql;
			sql += ") A) where rnum >= ? and rnum <= ?";
			
			pstmt = conn.prepareStatement(sql);

			int k = 0;
			pstmt.setString(++k, paramDto.getTbl());
			if (paramDto.getSearchGubun().equals("writer_subject_content")) {
				pstmt.setString(++k, '%' + paramDto.getSearchData() + '%');
				pstmt.setString(++k, '%' + paramDto.getSearchData() + '%');
				pstmt.setString(++k, '%' + paramDto.getSearchData() + '%');
			} else if (paramDto.getSearchGubun().equals("writer") || paramDto.getSearchGubun().equals("subject") || paramDto.getSearchGubun().equals("content")) {
				pstmt.setString(++k, '%' + paramDto.getSearchData() + '%');
			} else {

			}

			pstmt.setInt(++k, paramDto.getStartRecord());
			pstmt.setInt(++k, paramDto.getLastRecord());

			rs = pstmt.executeQuery();
			while (rs.next()) {
				SubBoardDTO dto = new SubBoardDTO();
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
	
	public SubBoardDTO getSelectOne(SubBoardDTO paramDto) {
		SubBoardDTO dto = new SubBoardDTO();
		conn = DB.dbConn();
		try {
			String sql = "";
			sql += "select * from ( ";
			
			sql += "select b.*, ";
			sql += "LAG(no) OVER (order by noticeNo desc, refNo desc, levelNo asc) preNo, ";
			sql += "LAG(subject) OVER (order by noticeNo desc, refNo desc, levelNo asc) preSubject, ";
			sql += "LEAD(no) OVER (order by noticeNo desc, refNo desc, levelNo asc) nxtNo, ";
			sql += "LEAD(subject) OVER (order by noticeNo desc, refNo desc, levelNo asc) nxtSubject ";
			sql += "from board b where tbl = ? ";

			if (paramDto.getSearchGubun() == null || paramDto.getSearchGubun().length() <= 0) {
				
			} else if (paramDto.getSearchGubun().equals("writer_subject_content")) {
				sql += "and (writer like ? or subject like ? or content like ?) ";
			} else if (paramDto.getSearchGubun().equals("writer") || paramDto.getSearchGubun().equals("subject") || paramDto.getSearchGubun().equals("content")) {
				sql += "and " + paramDto.getSearchGubun() + " like ? ";
			}
			
			sql += "order by noticeNo desc, refNo desc, levelNo asc";
			
			sql += ") where no = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			int k = 0;
			pstmt.setString(++k, paramDto.getTbl());
			if (paramDto.getSearchGubun() == null || paramDto.getSearchGubun().length() <= 0) {
				
			} else if (paramDto.getSearchGubun().equals("writer_subject_content")) {
				pstmt.setString(++k, '%' + paramDto.getSearchData() + '%');
				pstmt.setString(++k, '%' + paramDto.getSearchData() + '%');
				pstmt.setString(++k, '%' + paramDto.getSearchData() + '%');
			} else if (paramDto.getSearchGubun().equals("writer") || paramDto.getSearchGubun().equals("subject") || paramDto.getSearchGubun().equals("content")) {
				pstmt.setString(++k, '%' + paramDto.getSearchData() + '%');
			}
			pstmt.setInt(++k, paramDto.getNo());
			
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
				
				dto.setPreNo(rs.getInt("preNo"));
				dto.setPreSubject(rs.getString("preSubject"));
				dto.setNxtNo(rs.getInt("nxtNo"));
				dto.setNxtSubject(rs.getString("nxtSubject"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return dto;
	}
	  
	public int setInsert(SubBoardDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "insert into board values (seq_board.nextval, ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, sysdate, ?)";
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

	public int setUpdate(SubBoardDTO paramDto) {
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
	
	public int setDelete(SubBoardDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "";
			sql += "delete from board where no = ? and passwd = ?";
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
	
	
	
	
	
	
	
	
	
	
	
	public int getMaxNumRefNoNoticeNo(String gubun) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "";
			
//			if (gubun.equals("num")) {
//				sql = "select nvl(max(num), 0) maxValue from board";
//			} else if (gubun.equals("refNo")) {
//				sql = "select nvl(max(refNo), 0) maxValue from board";
//			} else if (gubun.equals("noticeNo")) {
//				sql = "select nvl(max(noticeNo), 0) maxValue from board";
//			}

			sql = "select nvl(max(" + gubun + "), 0) maxValue from board";
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
	
	//부모글의 refNo와 같은 것 중에서, 부모글의 levelNo보다 큰 값들은 +1 해라..
	public void setUpdateRelevel(SubBoardDTO paramDto) {
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
	
//	commentNo number not null primary key, -- 댓글 일련번호
//	boardNo number not null references board(no), -- 게시물 번호
//	writer varchar2(50) not null,
//	content clob not null,
//	passwd varchar2(50) not null,
//	memberNo number not null,
//	ip varchar2(50) not null,
//	regiDate date default sysdate
	
	public ArrayList<SubBoardCommentDTO> getCommentSelectAll(SubBoardCommentDTO paramDto) {
		ArrayList<SubBoardCommentDTO> list = new ArrayList<>();
		conn = DB.dbConn();
		try {
			String sql = "select * from boardComment where boardNo = ? order by commentNo desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getBoardNo());
			rs = pstmt.executeQuery();
			while (rs.next()) {
				SubBoardCommentDTO dto = new SubBoardCommentDTO();
				dto.setCommentNo(rs.getInt("commentNo"));
				dto.setBoardNo(rs.getInt("boardNo"));
				dto.setWriter(rs.getString("writer"));
				dto.setContent(rs.getString("content"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setIp(rs.getString("ip"));
				dto.setRegiDate(rs.getDate("regiDate"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}	
		return list;
	}
	
	public int setCommentInsert(SubBoardCommentDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "insert into boardComment values (seq_boardComment.nextval, ?,?,?,?,?,?, sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getBoardNo());
			pstmt.setString(2, paramDto.getWriter());
			pstmt.setString(3, paramDto.getContent());
			pstmt.setString(4, paramDto.getPasswd());
			pstmt.setInt(5, paramDto.getMemberNo());
			pstmt.setString(6, paramDto.getIp());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}	
		return result;
	}
	
	public int setCommentUpdate(SubBoardCommentDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "update boardComment set writer = ?, content = ? where commentNo = ? and passwd = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paramDto.getWriter());
			pstmt.setString(2, paramDto.getContent());
			pstmt.setInt(3, paramDto.getCommentNo());
			pstmt.setString(4, paramDto.getPasswd());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}	
		return result;
	}
	
	public int setCommentDelete(SubBoardCommentDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "delete from boardComment where commentNo = ? and passwd = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getCommentNo());
			pstmt.setString(2, paramDto.getPasswd());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}	
		return result;
	}
}