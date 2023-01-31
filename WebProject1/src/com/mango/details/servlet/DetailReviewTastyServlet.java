package com.mango.details.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import com.mango.details.dao.mangoDetailsDAO;
import com.mango.details.dto.mangoReviewDTO;

/**
 * Servlet implementation class DetailReviewTastyServlet
 */
@WebServlet("/DetailReviewTastyServlet")
public class DetailReviewTastyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//pageNum을 받아서,dto들의 모음을 돌려주는 servlet
		int plate = Integer.parseInt(request.getParameter("plate_id"));
		int pageNum = Integer.parseInt(request.getParameter("page"));
		int tastyLike = Integer.parseInt(request.getParameter("tastyLike"));
		mangoDetailsDAO mDAO = new mangoDetailsDAO();
		ArrayList<mangoReviewDTO> list = null;
		try {
			list = mDAO.getDetailReviewTasty(plate,pageNum,tastyLike);
		}catch(Exception e) { e.printStackTrace();}
		
		//JSON-array 만들기
		JSONArray jsonArray = new JSONArray();
		for(int i=0; i<=list.size()-1; i++) {
			mangoReviewDTO dto = list.get(i);
			JSONObject obj = new JSONObject();
			obj.put("memberImg", dto.getMemberImg());
			obj.put("name", dto.getName());
			obj.put("writeCount", dto.getWriteCount());
			obj.put("followCount", dto.getFollowCount());
			obj.put("holic", dto.getHolic()+"");
			obj.put("writeDate", dto.getWritedate()+"");
			obj.put("coment", dto.getComent());
			obj.put("img", dto.getImg());
			String str = "";
			for(int j=0; j<=dto.getImgNum().length-1; j++) {
				str += dto.getImgNum()[j];
				if(j<dto.getImgNum().length-1)
					str += ",,,";
			}
			if(str.length()>0)
				str = str.substring(0, str.length());
			obj.put("imgNum", str);
			
			obj.put("tasty", dto.getTasty());
			obj.put("id", dto.getId());
			obj.put("idx", dto.getIdx());
			obj.put("member", dto.getMember());
			jsonArray.add(obj);
		}

		//Remember : JSONArray를 JSONObject에 담아줘야함
		JSONObject objFinal = new JSONObject();
		objFinal.put("result",jsonArray);
		
		response.setContentType("application/json"); // 응답의 형식을 JSON이라고 정해줌.
		response.setCharacterEncoding("UTF-8");	// 응답의 한글인코딩설정 : response.getWriter() 전에 해야 함!
		PrintWriter out =  response.getWriter();
		out.println(objFinal);
	}

}
