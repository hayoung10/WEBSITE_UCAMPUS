package file;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.URLEncoder;

@WebServlet("/downloadAction")
public class downloadAction extends HttpServlet {
   private static final long serialVersionUID = 1L;

   protected void doGet(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
	   
	  request.setCharacterEncoding("UTF-8");
      String fileName = request.getParameter("file");//여기가바로 파일이름으로 받아올수 있다는 뜻인데 넹
      fileName = new String(fileName.getBytes("8859_1"),"UTF-8");
      
      String directory =  "C:\\upload";
      File file = new File(directory + "/" + fileName);//디렉토리 명 지정해서 file구조체 만들어주는곳
      String mimeType = getServletContext().getMimeType(file.toString());//여기서 아마 ??

      if (mimeType == null) {
         response.setContentType("application/octet-stream");//저장할때 이름저장하는곳은?
      }      
      response.setHeader("Content-Disposition", "attachment; filename=\"" + URLEncoder.encode(fileName, "utf-8"));
      
      FileInputStream  fileInputStream = new FileInputStream(file);//파일읽는곳
      ServletOutputStream servletOutputStream = response.getOutputStream();
      
      byte b[] = new byte[1024];
      int data = 0;
      
      while((data = (fileInputStream.read(b, 0 ,b.length))) != -1){
         servletOutputStream.write(b, 0, data);
      }
      
      servletOutputStream.flush();
      servletOutputStream.close();
      fileInputStream.close();
   }
}