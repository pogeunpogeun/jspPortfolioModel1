package shopProduct.model.dto;

import java.sql.Date;

public class ShopProductDTO {
	private int productCode;
	private String productName;
	private int productPrice;
	private int vendorCode;
	private String attachInfo;
	private Date regiDate;
	public int getProductCode() {
		return productCode;
	}
	public void setProductCode(int productCode) {
		this.productCode = productCode;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public int getProductPrice() {
		return productPrice;
	}
	public void setProductPrice(int productPrice) {
		this.productPrice = productPrice;
	}
	public int getVendorCode() {
		return vendorCode;
	}
	public void setVendorCode(int vendorCode) {
		this.vendorCode = vendorCode;
	}
	public String getAttachInfo() {
		return attachInfo;
	}
	public void setAttachInfo(String attachInfo) {
		this.attachInfo = attachInfo;
	}
	public Date getRegiDate() {
		return regiDate;
	}
	public void setRegiDate(Date regiDate) {
		this.regiDate = regiDate;
	}
	
	
}
