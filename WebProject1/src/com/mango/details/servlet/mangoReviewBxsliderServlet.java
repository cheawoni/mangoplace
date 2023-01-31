package com.mango.details.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.mango.details.dao.mangoDetailsDAO;
import com.mango.details.dto.mangoReviewDetailDTO;

@WebServlet("/mangoReviewBxsliderServlet")
public class mangoReviewBxsliderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int plate = Integer.parseInt(request.getParameter("plate_id"));
		int Mnumber = Integer.parseInt(request.getParameter("Mnumber"));
		mangoDetailsDAO mDAO = new mangoDetailsDAO();
		mangoReviewDetailDTO dto = null;
		try {
			dto = mDAO.getReviewDetail(plate,Mnumber);
		}catch(Exception e) {e.printStackTrace();}
		
		JSONArray jsonArray = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("name", dto.getName());
		obj.put("area", dto.getArea());
		obj.put("memberName", dto.getMemberName());
		obj.put("memberImg", dto.getMemberImg());
		obj.put("writeCount", dto.getMemberWriteCount());
		obj.put("followCount", dto.getMemberFollowCount());
		obj.put("idx", dto.getIdx());
		obj.put("id", dto.getId());
		obj.put("memberNumber", dto.getMemberNumber());
		String str = "";
		for(int j=0; j<=dto.getImg().length-1; j++) {
			str += dto.getImg()[j];
			if(j<dto.getImg().length-1)
				str += ",,,";
		}
		if(str.length()>0)
			str = str.substring(0, str.length());
		obj.put("img", str);
		obj.put("coment", dto.getComent());
		obj.put("writeDate", dto.getWriteDate());
		obj.put("tasty", dto.getTasty());
		jsonArray.add(obj);
		
		JSONObject objFinal = new JSONObject();
		objFinal.put("result",jsonArray);
		
		response.setContentType("application/json"); // 응답의 형식을 JSON이라고 정해줌.
		response.setCharacterEncoding("UTF-8");	// 응답의 한글인코딩설정 : response.getWriter() 전에 해야 함!
		PrintWriter out =  response.getWriter();
		out.println(objFinal);
		
		
	}
}
