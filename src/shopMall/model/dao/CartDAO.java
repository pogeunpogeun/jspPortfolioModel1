package shopMall.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import config.DB;
import shopMall.model.dto.CartDTO;
import shopProduct.model.dto.ShopProductDTO;

public class CartDAO {
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	public ArrayList<CartDTO> getSelectAll() {
	      ArrayList<CartDTO> list = new ArrayList<>();
	      conn = DB.dbConn();
	      try {
	         String sql = "";
	         sql += "select C.*, ";
				/*
				 * sql += "select c.*,("; sql +=
				 * "select productName from product p where p.productCode = c.productCode "; sql
				 * += ") productName, ("; sql +=
				 * "select productPrice from product p where p.productCode = c.productCode ";
				 * sql += ") productPrice "; sql += "from cart c "; sql +=
				 * "order by cartNo desc";
				 */
	         
				/*
				 * sql += "select c.*, "; sql += "("; sql +=
				 * "select productName from proudct p where p.productCode = c.productCode"; sql
				 * += ") productName, ";
				 * 
				 * sql += "("; sql +=
				 * "select productPrice from proudct p where p.productCode = c.productCode"; sql
				 * += ") productPrice, ";
				 */
	         sql += "(";
	         sql += "select productName || '/' || productPrice || '/' || vendorCode || '/' || attachInfo from product p where p.productCode = c.productCode";
	         sql += ") productInfo ";
	         
	         sql += "from cart c ";
	         sql += "order by cartNo desc ";	                  
	         pstmt = conn.prepareStatement(sql);
	         rs = pstmt.executeQuery();
	         while(rs.next()) {
	        	CartDTO dto = new CartDTO();
	            dto.setCartNo(rs.getInt("cartNo"));
				dto.setMemberNo(rs.getInt("memberNo"));
				dto.setProductCode(rs.getInt("productCode"));
				dto.setAmount(rs.getInt("amount"));
				dto.setRegiDate(rs.getDate("regiDate"));
				//dto.setProductName(rs.getString("productName"));
				//dto.setProductPrice(rs.getInt("productPrice"));
				dto.setProductInfo(rs.getString("productInfo"));
				list.add(dto);
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         DB.dbConnClose(rs, pstmt, conn);
	      }
	      return list;
	   }	
	public CartDTO getSelectOne(CartDTO paramDto) {
		CartDTO dto = new CartDTO();
		conn = DB.dbConn();
		try {
			String sql = "select * from cart where CartNo=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getCartNo());
			rs = pstmt.executeQuery();
			if(rs.next()) {
				dto.setCartNo(rs.getInt("cartNo"));
				dto.setMemberNo(rs.getInt("memberNo"));
				dto.setProductCode(rs.getInt("productCode"));
				dto.setAmount(rs.getInt("amount"));
				dto.setRegiDate(rs.getDate("regiDate"));
			}
		} catch (Exception e) {
			//e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}		
		return dto;
	}
	public int setInsert(CartDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "insert into cart values (seq_cart.nextval,?,?,?,sysdate)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getMemberNo());
			pstmt.setInt(2, paramDto.getProductCode());
			pstmt.setInt(3, paramDto.getAmount());		
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			//e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	public int setUpdate(CartDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "update cart set memberNo=?, productCode=?, amount=? where cartNo=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getMemberNo());
			pstmt.setInt(2, paramDto.getProductCode());
			pstmt.setInt(3, paramDto.getAmount());
			pstmt.setInt(4, paramDto.getCartNo());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			//e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	public int setDelete(CartDTO paramDto) {
		int result = 0;
		conn = DB.dbConn();
		try {
			String sql = "delete cart where cartNo=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, paramDto.getCartNo());
			result = pstmt.executeUpdate();
		} catch(Exception e) {
			//e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return result;
	}
	public int setDeleteBatch(String[] array) {
		int result = 0;
		int[] count = new int[array.length];
		conn = DB.dbConn();
		try {
			conn.setAutoCommit(false);
			String sql = "delete from cart where cartNo=?";
			pstmt = conn.prepareStatement(sql);
			
			for(int i=0; i<array.length; i++) {
				pstmt.setInt(1, Integer.parseInt(array[i]));
				pstmt.addBatch();
			}
			count = pstmt.executeBatch();
			conn.commit();
		} catch (Exception e) {
			e.printStackTrace();
			try {
				conn.rollback();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		} finally {
			try {
				conn.setAutoCommit(true);
			} catch (Exception e2) {
				e2.printStackTrace();
			}
			DB.dbConnClose(rs, pstmt, conn);
		}
		result = count.length;
		return result;
	}
	public ArrayList<CartDTO> getSelectCartProductGroup() {
		ArrayList<CartDTO> list = new ArrayList<>();
		conn = DB.dbConn();
		try {
			String sql = "";
			sql += "select p.productName productName, sum(c.amount * p.productPrice) buyMoney ";
			sql += "from cart c inner join product p on c.productCode = p.productCode ";
			sql += "group by p.productName ";
			sql += "order by productName asc ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CartDTO dto = new CartDTO();
				dto.setProductName(rs.getString("productName"));
				dto.setBuyMoney(rs.getInt("buyMoney"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			DB.dbConnClose(rs, pstmt, conn);
		}
		return list;
	}

}
