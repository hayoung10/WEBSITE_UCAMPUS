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
<title>U-Campus</title>
<link rel="stylesheet"
   href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"
   integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u"
   crossorigin="anonymous">
<style type="text/css">
   .middle_context{
      margin : 0 auto;
      text-align:center;
      width:450px;
      height:100px;
   }
    a:link {
        color: red;
        text-decoration: none;
    }

    a:visited {
        color: black;
        text-decoration: none;
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

    #wrap>#content_wrap {
        float: center;
        margin : 0 auto;
        padding: 10px;
        width: 980px;
    }

    #wrap>#content_wrap>#content {
        padding-right: 200px;
    }
</style>
<!-- 수직 목록 -->
<style>
    #wrap {
      margin : 0 auto;
      align: center;
      width: 1200px;
      background: #f0ad4e;
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
   margin : 0 auto;
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
   .top_context{
         text-align:center;
   }
   
   .list-group2{
      margin : 0 auto;
      text-align: center;
      width:480px;
   }
    #detail_list>ul>li.header {
        padding-left: 15px;
    }

    #detail_list>ul>li.header>p {
        font-weight: bold;
        color: rgb(48, 0, 0);
    }

    #table, th, td {
        text-align: center;
        border: 1px solid black;
    }

    #tableset {
        padding: 20px;
    }
</style>
</head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<body>

   <%
   String sectionName = request.getParameter("sectionName");
      String userID = null; //로그인 안 한 사람들은 null 값에 담기게 되는 것
         if (session.getAttribute("userID") != null) {
            System.out.println("여기 유캠 userID : "+session.getAttribute("userID"));
            userID = (String) session.getAttribute("userID");
         }
         if (userID == null) { //그리고 로그인이 되어있다면 이미 로그인이 되었다고 화면을 보여주는 것.
             PrintWriter script = response.getWriter();
             script.println("<script>");
             script.println("alert('로그인 하세요')");
             script.println("location.href='main.jsp'");
             script.println("</script>");
          }
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
      
        <% if(user.getUserIf()==0){
        %>
        <div id="content_wrap">

            <div id="detail_list">
                <h2>수강과목 - <% if (sectionName==null){%> 과목을 선택하세요<%}else {%> <%=sectionName %> <%} %></h2>
                <div id="tableset">
                    <table border="table1" width="800px" height="200px">
                        <thead>
                            <th>Name</th>
                            <th>Days / Time</th>
                            <th>Professor</th>
                        </thead>
                        <tbody>
                        <form method="post" action="lectureM.jsp">
                              <tr>
                                 <select class="" name="sem">
                                 <option value="" selected="selected" class="randomInput">2019년도 1학기</option>
                        </select> <select name="sectionName">
                           <li>
                              <option value="null" selected="selected">선택하세요</option>
                              <option value="aSubject"><%="aSubject" %>
                              <option value="bSubject"><%="bSubject" %>
                              <option value="dSubject"><%="dSubject" %>
                              </option>
                              <input type="submit" class="btn btn-xs btn-success" value="이동" style="width: 20; height: 20pt; ">
                           </li>
                        </select>
                              </tr>
                              </form>
                                 <%
                                 
                                 if(request.getParameter("sectionName") == null){
                                    SecDAO secDAO = new SecDAO();
                                    ArrayList<Sec> secList = secDAO.getstuSec(userID);
                                    for (int i =0; i<secList.size();i++){
                                       %>
                                       <tr>
                                          <td><%=secList.get(i).getSecName() %></td>
                                          <td><%= secList.get(i).getSecDaysTime()%></td>
                                 <td><%=secList.get(i).getSecUserName()%></td>
                                       </tr>
                                       <%
                                    }
                                       %>
                         <%
                               
                             } else if (request.getParameter("sectionName").equals("aSubject")){
                                %>
                                <tr>
                                   <td><%="aSubject" %></td>
                                   <td><%="RoomCham Mon1Wed2" %></td>
                                   <td><%="Aprofessor" %></td>
                                </tr>
                                <%
                             } else if (request.getParameter("sectionName").equals("bSubject")){
                           %>   
                                 <tr>
                                   <td><%="bSubject" %></td>
                                   <td><%="RoomSae Tue3Thu4" %></td>
                                   <td><%="Bprofessor" %></td>
                                </tr>
                           <%
                             } else if (request.getParameter("sectionName").equals("dSubject")) {
                           %>
                                 <tr>
                                   <td><%="dSubject" %></td>
                                   <td><%="RoomBi Mon3Wed4" %></td>
                                   <td><%="Bprofessor" %></td>
                                </tr>
                           <%
                             }
                                 System.out.println("herehere--" + request.getParameter("sectionName"));
        }
                           %>
 
                            </tbody>
                    </table>
                    <div>
                       <tr>
                          <%
                          SecDAO secDAO = new SecDAO();
                              ArrayList<Sec> secList = secDAO.getstuSec(userID);
                              int check = 0;
                          for (int i =0; i<secList.size();i++){
                             if (secList.get(i).getSecName().equals(request.getParameter("sectionName"))){
                                check = 1;
                             }
                          }
                          if (request.getParameter("sectionName") == null) {
                             check = 2;
                          }
                          if (check == 1){
                             %>
                             <form method="post" action="delete.jsp">
                             <input type="hidden" value=<%=sectionName %> name="sectionName">
                            <input type="submit" class="btn btn-xs btn-success pull-right" value="취소">
                            </form>
                            <%
                          } else if (check == 0){
                             System.out.println("여기여기여기");
                             %>
                             <form method="post" action="add.jsp">
                                <input type="hidden" value=<%=sectionName %> name="sectionName">
                               <input type="submit" class="btn btn-xs btn-success pull-right" value=등록>
                            </form>
                            <%
                          }
                                %>
                       </tr>
                    </div>
                </div>
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

</html>