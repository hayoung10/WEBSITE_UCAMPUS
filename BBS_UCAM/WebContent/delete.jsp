<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>

<%@ page import="java.io.PrintWriter"%> 
<%
 	request.setCharacterEncoding("UTF-8"); //건너오는 모든 데이터를 utf-8 로 받을 수 있게..
 %>
<!DOCTYPE html>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset="charset=UTF-8">
<title>강의 삭제</title>
</head>
<body>
	<%
		System.out.println("...");
		String sectionName = request.getParameter("sectionName");
		String userID = null;
		if (session.getAttribute("userID")!=null){
			userID = (String)session.getAttribute("userID");
		}
		if (userID == null) {
	    	 PrintWriter script = response.getWriter();
	         script.println("<script>");
	         script.println("alert('로그인 하세요')");
	         script.println("location.href='main.jsp'");
	         script.println("</script>");
	     }
		UserDAO userDAO = new UserDAO();
		User user = userDAO.getList(userID);
		System.out.println("userid:"+userID);
		
		int result = 0;
		System.out.println(request.getParameter("sectionName"));
		if (request.getParameter("sectionName").equals("aSubject")){
			result = userDAO.Delete(userID, 1);
		} else if (request.getParameter("sectionName").equals("bSubject")){
			result = userDAO.Delete(userID,2);
		} else if (request.getParameter("sectionName").equals("dSubject")){
			result = userDAO.Delete(userID,3);
		}
		if(result == 1){
			System.out.println("OK");
			session.setAttribute("userID", user.getUserID());
			PrintWriter script = response.getWriter();
	         script.println("<script>");
	         script.println("alert('강의가 취소되었습니다')");
	         script.println("location.href='lectureM.jsp'");
	         script.println("</script>");
		} else if (result == -1){
			System.out.println("NOPE");
		}
	%>
</body>
</html>