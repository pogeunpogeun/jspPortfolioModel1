package member.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import config.DB;
import member.model.dto.MemberDTO;

public class MemberDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public ArrayList<MemberDTO> getSelectAll(String searchGubun, String searchData) {
		ArrayList<MemberDTO> list = new ArrayList<>();
		conn = DB.dbConn();
		try {
			String sql = "select * from member where 1 = 1 ";
			if(searchGubun.equals("id")) {
				sql += " and id like ? ";
			} else if(searchGubun.equals("name")) {
				sql += " and name like ? ";
			} else if(searchGubun.equals("phone")) {
				sql += " and phone like ? ";
			} else if(searchGubun.equals("jumin")) {
				sql += " and jumin like ? ";
			} else if(searchGubun.equals("all_info")) {
				sql += " and (id like ? or name like ? or phone like ? or jumin like ?)";
			} 
				sql += "order by no desc";
						
			pstmt = conn.prepareStatement(sql);
			
			if(searchGubun.equals("id")) {
				pstmt.setString(1, '%' + searchData + '%');
			} else if (searchGubun.equals("name")) {
				pstmt.setString(1, '%' + searchData + '%');
			} else if (searchGubun.equals("phone")) {
				pstmt.setString(1, '%' + searchData + '%');
			} else if (searchGubun.equals("jumin")) {
				pstmt.setString(1, '%' + searchData + '%');
			} else if (searchGubun.equals("all_info")) {
				pstmt.setString(1, '%' + searchData + '%');
				pstmt.setString(2, '%' + searchData + '%');
				pstmt.setString(3, '%' + searchData + '%');
				pstmt.setString(4, '%' + searchData + '%');
			}			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setNo(rs.getInt("no"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setPhone(rs.getString("phone"));
				dto.setEmail(rs.getString("email"));
				dto.setJumin(rs.getString("jumin"));
				dto.setJuso1(rs.getString("juso1"));
				dto.setJuso2(rs.getString("juso2"));
				dto.setJuso3(rs.getString("juso3"));
				dto.setJuso4(rs.getString("juso4"));
				dto.setGrade(rs.getString("grade"));
				dto.setRegiDate(rs.getDate("regiDate"));
				dto.setAttachInfo(rs.getString("attachInfo"));
				list.add(dto);			
			}
		} catch(Exception e) {
			
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return list;
	}
	public MemberDTO getSelectOne(MemberDTO paramDto) {
		MemberDTO dto = new MemberDTO();
		conn = DB.dbConn();
		try {
			String sql = "select * from member where no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getNo());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setNo(rs.getInt("no"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setPhone(rs.getString("phone"));
				dto.setEmail(rs.getString("email"));
				dto.setJumin(rs.getString("jumin"));
				dto.setJuso1(rs.getString("juso1"));
				dto.setJuso2(rs.getString("juso2"));
				dto.setJuso3(rs.getString("juso3"));
				dto.setJuso4(rs.getString("juso4"));
				dto.setGrade(rs.getString("grade"));
				dto.setRegiDate(rs.getDate("regiDate"));
				dto.setAttachInfo(rs.getString("attachInfo"));
			}
		} catch (Exception e) {
			//e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}		
		return dto;
	}
	
	public MemberDTO getLogin(MemberDTO paramDto) {
		MemberDTO dto = new MemberDTO();		
		conn = DB.dbConn();
		try {
			String sql = "select no, name, grade from member where id=? and passwd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paramDto.getId());
			pstmt.setString(2, paramDto.getPasswd());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setNo(rs.getInt("no"));
				dto.setName(rs.getString("name"));
				dto.setGrade(rs.getString("grade"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return dto;
	}
	
	public int setInsert(MemberDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "insert into member values (seq_member.nextval,?,?,?,?,?,?,?,?,?,?,?,sysdate,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paramDto.getId());
			pstmt.setString(2, paramDto.getPasswd());
			pstmt.setString(3, paramDto.getName());
			pstmt.setString(4, paramDto.getPhone());
			pstmt.setString(5, paramDto.getEmail());
			pstmt.setString(6, paramDto.getJumin());
			pstmt.setString(7, paramDto.getJuso1());
			pstmt.setString(8, paramDto.getJuso2());
			pstmt.setString(9, paramDto.getJuso3());
			pstmt.setString(10, paramDto.getJuso4());
			pstmt.setString(11, paramDto.getGrade());
			pstmt.setString(12, paramDto.getAttachInfo());			
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			//e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	public int setUpdate(MemberDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "update member set phone=?, email=?, juso1=?, juso2=?, juso3=?, juso4=?, grade=? where no=? and passwd=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paramDto.getPhone());
			pstmt.setString(2, paramDto.getEmail());
			pstmt.setString(3, paramDto.getJuso1());
			pstmt.setString(4, paramDto.getJuso2());
			pstmt.setString(5, paramDto.getJuso3());
			pstmt.setString(6, paramDto.getJuso4());
			pstmt.setString(7, paramDto.getGrade());
			pstmt.setInt(8, paramDto.getNo());
			pstmt.setString(9, paramDto.getPasswd());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			//e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	public int setDelete(MemberDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "delete member where no=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getNo());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			//e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}

}
