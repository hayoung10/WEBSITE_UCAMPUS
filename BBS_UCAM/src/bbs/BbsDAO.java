package bbs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class BbsDAO {

   private Connection conn;
   
   private ResultSet rs;
   
   public BbsDAO() {
	      try {
				String dbURL="jdbc:mysql://localhost:3306/bbs";
		         String dbID="root";
		         String dbPassword="#####"; // db password 입력
	         Class.forName("com.mysql.jdbc.Driver");
	         conn=DriverManager.getConnection(dbURL,dbID,dbPassword);
	               
	      }catch(Exception e) {
	         e.printStackTrace();
	      }
	   }
   
   public String getDate() {
	   String SQL="SELECT NOW()";
	   try {
		   PreparedStatement pstmt=conn.prepareStatement(SQL);
		   rs=pstmt.executeQuery();
		   if(rs.next()) {
			   return rs.getString(1);
		   }
	   }catch(Exception e){
		   e.printStackTrace();
	   }
	   return "";
   }
   
   public int getNext() {
	   String SQL="SELECT bbsID FROM Bbs ORDER BY bbsID DESC";
	   try {
	
		   PreparedStatement pstmt=conn.prepareStatement(SQL);
		   rs=pstmt.executeQuery();
		   if(rs.next()) {
			   return rs.getInt(1)+1;
		   }
		   return 1;//첫번째 계시물인경우
	   }catch(Exception e){
		   e.printStackTrace();
	   }
	   return -1;//데이터베이스 오류인경우
   }
   
   public int write(String bbsTitle,String userID,String setBbsText, String recvID) {
	   String SQL="INSERT INTO Bbs VALUES(?,?,?,?,?,?,?)";
	   try {
		   PreparedStatement pstmt=conn.prepareStatement(SQL);
		   pstmt.setInt(1,getNext());
		   pstmt.setString(2,bbsTitle);
		   pstmt.setString(3,userID);
		   pstmt.setString(4,recvID);
		   pstmt.setString(5,getDate());
		   pstmt.setString(6,setBbsText);
		   pstmt.setInt(7,1);   
		   return pstmt.executeUpdate();
	   }catch(Exception e){
		   e.printStackTrace();
	   }
	   return -1;//데이터베이스 오류인경우
   }
   public  ArrayList<Bbs> getList(int pageNumber)
   {
	   String SQL="SELECT * FROM Bbs WHERE bbsID<? AND bbsAvailable =1 ORDER BY bbsID DESC LIMIT 10";
	   ArrayList<Bbs> list = new ArrayList<Bbs>();
	   try {
		   PreparedStatement pstmt=conn.prepareStatement(SQL);
		   pstmt.setInt(1,getNext()-(pageNumber -1)*10);
		   rs=pstmt.executeQuery();
		   while(rs.next()) {
			   Bbs bbs=new Bbs();
	           bbs.setBbsID(rs.getInt(1));
	           bbs.setBbsTitle(rs.getString(2));
	           bbs.setBbsWriteuserID(rs.getString(3));
	           bbs.setBbsEmail(rs.getString(4));
	           bbs.setBbsTime(rs.getString(5));
	           bbs.setBbsText(rs.getString(6));
	           bbs.setBbsAvailable(rs.getInt(7));
	           list.add(bbs);
		   }
	   }catch(Exception e){
		   e.printStackTrace();
	   }
	   return list;//데이터베이스 오류인경우
   }
   public boolean nextPage(int pageNumber) {
	   String SQL="SELECT * FROM Bbs WHERE bbsID<? AND bbsAvailable =1";
	   try {
		   PreparedStatement pstmt=conn.prepareStatement(SQL);
		   pstmt.setInt(1,getNext()-(pageNumber -1)*10);
		   rs=pstmt.executeQuery();
		   if(rs.next()) {
			  return true;
		   }
	   }catch(Exception e){
		   e.printStackTrace();
	   }
	   return false;//데이터베이스 오류인경우   
   }
   public  Bbs getBbs(int bbsID)
   {
	   String SQL="SELECT * FROM Bbs WHERE bbsID = ?";
	   ArrayList<Bbs> list = new ArrayList<Bbs>();
	   try {
		   PreparedStatement pstmt=conn.prepareStatement(SQL);
		   pstmt.setInt(1,bbsID);
		   rs=pstmt.executeQuery();
		   while(rs.next()) {
			   Bbs bbs=new Bbs();
	           bbs.setBbsID(rs.getInt(1));
	           bbs.setBbsTitle(rs.getString(2));
	           bbs.setBbsWriteuserID(rs.getString(3));
	           bbs.setBbsEmail(rs.getString(4));
	           bbs.setBbsTime(rs.getString(5));
	           bbs.setBbsText(rs.getString(6));
	           bbs.setBbsAvailable(rs.getInt(7));
	           return bbs;
		   }
	   }catch(Exception e){
		   e.printStackTrace();
	   }
	   return null;//데이터베이스 오류인경우
   }
   public int update(int bbsID,String bbsTitle,String bbsText) {
	   String SQL="UPDATE Bbs SET bbsTitle=? , bbsText=? WHERE bbsID=?";
	   try {
		   PreparedStatement pstmt=conn.prepareStatement(SQL);
		   pstmt.setString(1,bbsTitle);
		   pstmt.setString(2,bbsText);
		   pstmt.setInt(3,bbsID);
		   return pstmt.executeUpdate();
	   }catch(Exception e){
		   e.printStackTrace();
	   }
	   return -1;//데이터베이스 오류인경우
   }
   public int delete(int bbsID) {
	   String SQL="UPDATE Bbs SET bbsAvailable=0 WHERE bbsID=?";
	   try {
		   PreparedStatement pstmt=conn.prepareStatement(SQL);
		   pstmt.setInt(1,bbsID);
		   return pstmt.executeUpdate();
	   }catch(Exception e){
		   e.printStackTrace();
	   }
	   return -1;//데이터베이스 오류인경우
   }
}