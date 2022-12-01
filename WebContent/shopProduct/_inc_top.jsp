<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.apache.tika.Tika"%>
<%@page import="shopProduct.model.dao.ShopProductDAO"%>
<%@page import="shopProduct.model.dto.ShopProductDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="java.util.UUID"%>
<%@page import="java.util.Enumeration"%>
<%@page import="config.Util"%>
<% 
	String attachPath = "C:/HHJ/attach";
	String uploadPath = attachPath + request.getContextPath() + "/product";
	int maxUpload = 1024 * 1024 * 100;
	String encoding = "UTF-8";
%>