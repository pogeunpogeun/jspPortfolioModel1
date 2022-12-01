package shopProduct.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import config.DB;
import shopProduct.model.dto.ShopProductDTO;

public class ShopProductDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;	
	public ArrayList<ShopProductDTO> getSelectAllForSearch(String searchGubun, String searchData, int startRecord, int lastRecord) {
		String searchValue = "O";
		if(searchGubun == null || searchGubun.trim().equals("")) { searchGubun = ""; }
		if(searchData == null || searchData.trim().equals("")) { searchData = ""; }
		if(searchGubun.equals("") || searchData.trim().equals("")) { searchValue = "X"; searchGubun = ""; searchData = ""; }
		
		ArrayList<ShopProductDTO> list = new ArrayList<>();
		conn = DB.dbConn();
		try {
			String basicSql = "";
			basicSql += "select * from product ";
			if(searchValue.equals("O")) {
				if(searchGubun.equals("productName")) {
					basicSql += "where productName like ? ";
				}
			}
			basicSql += "order by productCode asc";
			
			String sql = "";
			sql += "select * from (select A.*, Rownum rnum from (";
			sql += basicSql;
			sql += ") A) where rnum >= ? and rnum <= ?";
			
			pstmt = conn.prepareStatement(sql);
			
			
			if(searchValue.equals("O")) {
				if(searchGubun.equals("productName")) {
					pstmt.setString(1, '%' + searchData + '%');
					pstmt.setInt(2, startRecord);
					pstmt.setInt(3, lastRecord);
				}					
			} else {
				pstmt.setInt(1, startRecord);
				pstmt.setInt(2, lastRecord);
			}
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ShopProductDTO dto = new ShopProductDTO();
				dto.setProductCode(rs.getInt("productCode"));
				dto.setProductName(rs.getString("productName"));
				dto.setProductPrice(rs.getInt("productPrice"));
				dto.setVendorCode(rs.getInt("vendorCode"));
				dto.setAttachInfo(rs.getString("attachInfo"));
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
	public ArrayList<ShopProductDTO> getSelectAll() {
	      ArrayList<ShopProductDTO> list = new ArrayList<>();
	      conn = DB.dbConn();
	      try {
	         String sql = "select * from product";
	         pstmt = conn.prepareStatement(sql);
	         rs = pstmt.executeQuery();
	         while(rs.next()) {
	            ShopProductDTO dto = new ShopProductDTO();
	            dto.setProductCode(rs.getInt("productCode"));
				dto.setProductName(rs.getString("productName"));
				dto.setProductPrice(rs.getInt("productPrice"));
				dto.setVendorCode(rs.getInt("vendorCode"));
				dto.setAttachInfo(rs.getString("attachInfo"));
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
	public ShopProductDTO getSelectOne(ShopProductDTO paramDto) {
		ShopProductDTO dto = new ShopProductDTO();
		conn = DB.dbConn();
		try {
			String sql = "select * from product where productCode = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getProductCode());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setProductCode(rs.getInt("productCode"));
				dto.setProductName(rs.getString("productName"));
				dto.setProductPrice(rs.getInt("productPrice"));
				dto.setVendorCode(rs.getInt("vendorCode"));
				dto.setAttachInfo(rs.getString("attachInfo"));
				dto.setRegiDate(rs.getDate("regiDate"));
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return dto;
	}
	public int setInsert(ShopProductDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "insert into product values (seq_product.nextval,?,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paramDto.getProductName());
			pstmt.setInt(2, paramDto.getProductPrice());
			pstmt.setInt(3, paramDto.getVendorCode());
			pstmt.setString(4, paramDto.getAttachInfo());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	public int setUpdate(ShopProductDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "update product set productName = ?, productPrice = ?, attachInfo = ? where productCode = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paramDto.getProductName());
			pstmt.setInt(2, paramDto.getProductPrice());
			pstmt.setString(3, paramDto.getAttachInfo());
			pstmt.setInt(4, paramDto.getProductCode());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	public int setDelete(ShopProductDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "delete from product where productCode = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getProductCode());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	public int getTotalRecord(String searchGubun, String searchData) {
		String searchValue = "O";
		if(searchGubun == null || searchGubun.trim().equals("")) { searchGubun = ""; }
		if(searchData == null || searchData.trim().equals("")) { searchData = ""; }
		if(searchGubun.equals("") || searchData.equals("")) { searchValue = "X"; searchGubun = ""; searchData = ""; }
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "";
			if(searchValue.equals("X")) { // 검색 안 할때
				sql = "select count(*) recordCounter from product";
			} else { // 검색 할 때
				if(searchGubun.equals("productName")) {
					sql = "select count(*) recordCounter from board where " + searchGubun + " like ?";
				}
			}
			pstmt = conn.prepareStatement(sql);
			
			if(searchValue.equals("X")) {
				
			} else {
				if(searchGubun.equals("productName")) {
					pstmt.setString(1, '%' + searchData + '%');
				} 
			}
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt("recordCounter");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
}