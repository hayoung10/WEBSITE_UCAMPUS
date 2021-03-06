<%@ page contentType="text/html; charset=UTF-8" %>

<%@ page import="file.FileDTO"%>
<%@ page import="file.FileDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="user.User"%>
<%@ page import="user.UserDAO"%>
<%@ page import="shs.Sec"%>
<%@ page import="shs.SecDAO"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.io.PrintWriter"%>


<%
   request.setCharacterEncoding("UTF-8");
%>


<!DOCTYPE html>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<title>Professor file upload</title>

<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
   integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
   crossorigin="anonymous">

<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css"
   integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp"
   crossorigin="anonymous">

<script
   src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"
   integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa"
   crossorigin="anonymous"></script>

<title>강의자료실</title>

<style type="text/css">
a:link {
   color: black;
   text-decoration: none;
}

a:visited {
   color: black;
   text-decoration: none;
}
#main_footer {
   margin : 0 auto;
   position: relative;
   width: 1200px;
   left: 0%;
   text-align: right;
   padding: 10px;
   background: rgb(48, 0, 0);
   color: white;
}
a:hover {
   color: blue;
   text-decoration: underline;
}
</style>
<style>
* {
   margin: 0;
   padding: 0;
}

body {
   font-family: 'Helvetica', sans-serif;
}

li {
   list-style: none;
}

a {
   text-decoration: none;
}
</style>
<!-- 헤더 -->
<style>
#main_header {
   height: 60px;
   line-height: 60px;
   width: 1200px;
   text-align: center;
   background: rgb(202, 84, 5);
   color: white;
}
</style>
<!-- 네비게이션 -->
<style>
#main_gnb {
   overflow: hidden;
   background: rgb(48, 0, 0);
   width: 1200px;
   color: white;
}

#main_gnb>ul.left {
   overflow: hidden;
   float: left;
}

#main_gnb>ul.right {
   overflow: hidden;
   float: right;
}

#main_gnb>ul.left>li {
   float: left;
}

#main_gnb>ul.right>li {
   float: left;
}

/* a 태그 설정 */
#main_gnb a {
   display: block;
   padding: 10px 20px;
   color: white;
   font-weight: bold;
}

body {
   min-width: 1200px;
}
</style>
<!-- 콘텐츠 -->
<style>
#wrap {
   overflow: hidden;
}

#wrap>#main_lnb {
   float: left;
   width: 200px;
}


#wrap>#content_wrap>#content {
   padding-right: 200px;
}
</style>
<!-- 수직 목록 -->
<style>
#wrap {
   width: 1200px;
   background: rgba(202, 84, 5, 0.712);
}

#main_lnb>ul>li>a {
   display: block;
   height: 40px;
   line-height: 40px;
   padding-left: 15px;
   color: white;
   font-weight: bold;
}

#main_lnb_bold {
   font-weight: bold;
   padding: 10px;
   font-size: 25px;
   text-align: center;
}
</style>
<!-- 본문 -->
<style>
#content {
   background: white;
   border: 1px solid rgb(255, 255, 255);
}

article {
   padding: 20px;
}
</style>
<!-- 푸터 -->
<style>
#main_footer {
   position: relative;
   width: 1200px;
   left: 0%;
   text-align: right;
   padding: 10px;
   background: rgb(48, 0, 0);
   color: white;
}

#footer_photo {
   float: left;
}
</style>
<style>
#detail_list {
   overflow: hidden;
   padding: 10px;
   background: rgb(200, 206, 206);
   padding-bottom: 15px;
   border: 10px solid white;
}

#detail_list>ul {
   float: left;
   width: 800px;
}

#detail_list>ul>li {
   height: 20px;
   margin-top: 5px;
   padding: 3px 5px;
   color: rgb(0, 0, 0);
   white-space: nowrap;
   overflow: hidden;
   text-overflow: ellipsis;
}

#detail_list>ul>li.header {
   padding-left: 15px;
}
.top_context{
         text-align:center;
}
#detail_list>ul>li.header>p {
   font-weight: bold;
   color: rgb(48, 0, 0);
}

#table, th, td {
   text-align: center;
   border: 1px solid black;
}
.list-group2{
      margin : 0 auto;
      text-align: center;
      width:480px;
}


#wrap>#content_wrap {
        float: center;
        margin : 0 auto;
        padding: 10px;
        width: 980px;
}
#wrap {
      margin : 0 auto;
      align: center;
      width: 1200px;
      background: #f0ad4e;
   }
.middle_context{
      margin : 0 auto;
      text-align:center;
      width:450px;
      height:100px;
}
#tableset {
   padding: 20px;
}
</style>

</head>

<body>
   <%
      String sectionName = request.getParameter("sectionName");
      String userID = null; //로그인 안 한 사람들은 null 값에 담기게 되는 것
      if (session.getAttribute("userID") != null) {
         userID = (String) session.getAttribute("userID");
      }
      if (userID == null) { //그리고 로그인이 되어있다면 이미 로그인이 되었다고 화면을 보여주는 것.
         PrintWriter script = response.getWriter();
         script.println("<script>");
         script.println("alert('로그인 하세요')");
         script.println("location.href='main.jsp'");
         script.println("</script>");
      }
      //이 부분이 내가 나중에 유저 아이디를 가져올 때 써야 하는 부분이다!
   %>
   <%
      UserDAO userDAO = new UserDAO();
      User user = userDAO.getList(userID);
   %>

    <h1>
      <div class="top_context">
         <img src="images/logo.gif"><br>
         <a href="ucammain.jsp">광운대학교 유캠퍼스
      </h1>
      </a>
   </div>
   <br>
   
   <div class="middle_context">
      <span class="middle_context2">
         <button type="button" class="btn btn-lg btn-warning"><h4><%=user.getUserName()%></h4></button>      
      </span>
      <span class="middle_context2">
         <button type="button" class="btn btn-lg btn-warning" onclick="location.href='main.jsp'"><h4>광운대학교 홈페이지</h2></button>
      </span>
      <span class="middle_context2">
         <button type="button" class="btn btn-lg btn-warning" onclick="location.href='logoutAction.jsp'"><h4>로그아웃</h2></button>
      </span>
   </div>

   <div class="main_lnb">
      <div class="col-sm-4 list-group2">
          <div class="list-group list-group2" style="width:330%; margin:0 auto; float:none">
            <a href="#" class="list-group-item active lll">U-CAMPUS</a>
            <a href="#" class="list-group-item lll">강의 종합정보</a>
            <a href="lectureData.jsp" class="list-group-item lll">강의자료실</a>
            <% if(user.getUserIf()==1){ %>
               <a href="search.jsp" class="list-group-item">수강생 관리</a>
            <% } else {%>  
               <a href="lectureM.jsp" class="list-group-item">수강과목 조회</a>
            <% } %>
          </div>
        </div>
   </div><br><br>

   <div id="wrap">
         <div id="content_wrap">
            <div id="detail_list">
               <table class="table table-bordered">
                  <tbody>
                       <form action="sendMail.jsp" method="post">
            <th>List</th>
                        <td>
                           <div class="column -lefs=">
                              <div class="form-group" style="text-align: left;">
                                 <%
                                    UserDAO userDAOem = new UserDAO();
                                    ArrayList<User> list = userDAOem.getstudysec(sectionName);
                                    for (int i = 0; i < list.size(); i++) {
                                 %>
                                 <label class="btn btn-default"> <input
                                    type="checkbox" autocomplete="off" name=<%=list.get(i).getUserID()%>
                                    value=<%=list.get(i).getUserEmail()%>><%=list.get(i).getUserName()%>
                                 </label>
                                 <%
                                    }
                                 %>
                                 
                              </div>
                           </div>
                        </td>
            
                <tr><td>제목 : </td><td><input type="text" style="width:500px;" name="subject" /></td></tr>
                <tr><td>내용 :</td><td><textarea name="content" style="width:500px; height:200px;"></textarea></td></tr>
                <tr><td colspan="2" style="text-align:right;"><input class="btn btn-xs btn-success pull-right" type="submit" value="전송"/></td></tr>
              </form>

                  </tbody>
               </table>
            </div>
         </div>
      </div>
      <footer id="main_footer">
        <div id="footer_photo">
            <img src="images/logo.gif" width="180" height="56" />
        </div>
        <h4>　</h4>
        <h4>서울 노원구 광운로 20()월계동 447-1) 광운대학교 TEL. 02-940-5114 / Mail. webadmin@kw.ac.kr</h4>
        <address>DATABASE TEAM KSC MHY LSM</address>
    </footer>
</body>