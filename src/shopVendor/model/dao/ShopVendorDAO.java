package shopVendor.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import config.DB;
import shopVendor.model.dto.ShopVendorDTO;

public class ShopVendorDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;	
	public ArrayList<ShopVendorDTO> getSelectAll() {
		ArrayList<ShopVendorDTO> list = new ArrayList<>();
		conn = DB.dbConn();
		try {
			String sql = "select * from vendor order by vendorCode asc";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ShopVendorDTO dto = new ShopVendorDTO();
				dto.setVendorCode(rs.getInt("vendorCode"));
				dto.setVendorName(rs.getString("vendorName"));
				dto.setRegiDate(rs.getDate("regiDate"));
				list.add(dto);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return list;
	}
	public ShopVendorDTO getSelectOne(ShopVendorDTO paramDto) {
		ShopVendorDTO dto = new ShopVendorDTO();
		conn = DB.dbConn();
		try {
			String sql = "select * from vendor where vendorCode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getVendorCode());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setVendorCode(rs.getInt("vendorCode"));
				dto.setVendorName(rs.getString("vendorName"));
				dto.setRegiDate(rs.getDate("regiDate"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return dto;
	}
	public int setInsert(ShopVendorDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "insert into vendor values (seq_product.nextval,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paramDto.getVendorName());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	public int setUpdate(ShopVendorDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "update vendor set vendorName=? where vendorCode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paramDto.getVendorName());
			pstmt.setInt(2, paramDto.getVendorCode());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	public int setDelete(ShopVendorDTO paramDto) {
		System.out.println("123213 : ->" + paramDto.getVendorCode());
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "delete from vendor where vendorCode=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getVendorCode());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
}
