package subBoard.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import config.DB;
import subBoard.model.dto.SubBoardChkDTO;

public class SubBoardChkDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public ArrayList<SubBoardChkDTO> getSelectAll() {
		ArrayList<SubBoardChkDTO> list = new ArrayList<>();
		conn = DB.dbConn();
		try {
			String sql = "select * from boardChk";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				SubBoardChkDTO dto = new SubBoardChkDTO();
				dto.setBoardChkNo(rs.getInt("boardChkNo"));
				dto.setTbl(rs.getString("tbl"));
				dto.setTblName(rs.getString("tblName"));
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
	public SubBoardChkDTO getSelectOne(SubBoardChkDTO paramDto) {
		SubBoardChkDTO dto = new SubBoardChkDTO();
		conn = DB.dbConn();
		try {
			String sql = "select * from boardChk where boardChkNo = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getBoardChkNo());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setBoardChkNo(rs.getInt("boardChkNo"));
				dto.setTbl(rs.getString("tbl"));
				dto.setTblName(rs.getString("tblName"));
				dto.setRegiDate(rs.getDate("regiDate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return dto;
	}
	public int setInsert(SubBoardChkDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "insert into boardChk values (seq_boardChk.nextval,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paramDto.getTbl());
			pstmt.setString(2, paramDto.getTblName());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	public int setUpdate(SubBoardChkDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "update boardChk set tbl = ?, tblName = ? where boardChkNo = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paramDto.getTbl());
			pstmt.setString(2, paramDto.getTblName());
			pstmt.setInt(3, paramDto.getBoardChkNo());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	public int setDelete(SubBoardChkDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "delete from boardChk where boardChkNo = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getBoardChkNo());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	public SubBoardChkDTO getSelectOne(String tbl) {
		SubBoardChkDTO dto = new SubBoardChkDTO();
		conn = DB.dbConn();
		try {
			String sql = "select boardChkNo from boardChk where tbl = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tbl);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setBoardChkNo(rs.getInt("boardChkNo"));
				dto.setTblName(rs.getString("tblName"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return dto;
	}
}
