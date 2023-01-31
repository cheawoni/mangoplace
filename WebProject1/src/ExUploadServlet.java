

import java.io.File;
import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/ExUploadServlet")
public class ExUploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String path = request.getRealPath("upload");
		System.out.println("절대경로 : " + path);
		
		// upload 폴더가 없으면 폴더 생성.
		File filePath = new File(path);
		if(!filePath.exists()) {
			filePath.mkdirs();
		}
		
		int size = 10 * 1024 * 1024;	// 10MB (파일크기제한)								a.jpg / b.jpg / "a2.jpg" 파일명이 동일하면 자동으로 파일명을 바꿔줌
		MultipartRequest multi = new MultipartRequest(request, path, size, "UTF-8", new DefaultFileRenamePolicy());
		// 파일 저장 끝. 이제 파일에 대한 정보(파일이름)를 multi객체로부터 뽑아내야...
		// 1) 파일 이름은 어떻게 -
		Enumeration files = multi.getFileNames();
		String filename1 = multi.getFilesystemName((String)files.nextElement());
		System.out.println("파일명 : " + filename1);
		
		// 2) request.getParameter("desc")가 안되는데, 그럼 어떻게 -
		System.out.println("이게 안 된다고? : " + request.getParameter("desc"));
		System.out.println("설명 : " + multi.getParameter("desc"));
		
		request.setAttribute("desc", multi.getParameter("desc"));
		request.setAttribute("img", filename1);
		request.getRequestDispatcher("ExUploadResult.jsp").forward(request, response);
	}

}
