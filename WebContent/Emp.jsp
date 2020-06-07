<%@page import="java.sql.SQLException"%>
<%@page import="oracle.jdbc.pool.OracleDataSource"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%! 
	PreparedStatement stmt;
	Connection con;
	public Connection getDBconwithOracle()
	{
		Connection con=null;
		try
		{
		OracleDataSource ods= new OracleDataSource();
		ods.setURL("jdbc:oracle:thin:@localhost:1521:xe");
		con=ods.getConnection("gurpreet","icsd");
		}
		catch(SQLException se)
		{
			System.out.println(se.getMessage());
		}
		return con;
	}
	public void jspInit()
	{
		
		try
		{
			con=getDBconwithOracle();
			stmt=con.prepareStatement("insert into tblemp values(?,?,?,?,?)");
		}
		catch(SQLException se)
		{
			se.printStackTrace();
		}
	}
	public void jspDestroy()
	{
		try
		{
			stmt.close();
			con.close();
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
%>
<!-- this is service method -->
<%
	String strEmpno,strEmpname,strEage,strEadd,strEsal;
	strEmpno=request.getParameter("txtEmpno");
	strEmpname=request.getParameter("txtEmpname");
	strEage=request.getParameter("txtEage");
	strEadd=request.getParameter("txtEadd");
	strEsal=request.getParameter("txtEsal");
	
	stmt.setString(1, strEmpno);
	stmt.setString(2, strEmpname);
	stmt.setString(3, strEage);
	stmt.setString(4, strEadd);
	stmt.setString(5, strEsal);
	
	stmt.executeUpdate();
	out.println("EMP inserted into table");
%>
	
	<%--<%@ include file ="EmpForm.html"%>--%>
</body>
</html>