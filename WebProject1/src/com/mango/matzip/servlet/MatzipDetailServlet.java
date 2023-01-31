package com.mango.matzip.servlet;

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

import com.mango.matzip.dao.MangoDAO;
import com.mango.matzip.dto.MatzipDetailDTO;

@WebServlet("/MatzipDetailServlet")
public class MatzipDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("서블릿!");
		
		int pageNum = Integer.parseInt(request.getParameter("page"));
		//System.out.println(pageNum);
		int idx = Integer.parseInt(request.getParameter("idx"));
		//System.out.println(idx);
		
		MangoDAO Mango = new MangoDAO();
		ArrayList<MatzipDetailDTO> list = null;
		try {
			list = Mango.getMatzipListDetailWithPaging(idx, pageNum);
		} catch(Exception e) {
			e.printStackTrace();
		}
		JSONArray jsonArray = new JSONArray();
		for(int i=0; i<=list.size()-1; i++) {
			MatzipDetailDTO dto = list.get(i);
			JSONObject obj = new JSONObject();
			obj.put("main_img", dto.getMain_img());
			obj.put("plate_id", dto.getPlate_id());
			obj.put("restaurant_order", dto.getRestaurant_order());
			obj.put("name", dto.getName());
			obj.put("score", dto.getScore());
			obj.put("street_address", dto.getStreet_address());
			obj.put("recommended_review", dto.getRecommended_review());
			obj.put("member_img", dto.getMember_img());
			obj.put("member_number", dto.getMember_number());
			obj.put("member_id", dto.getMember_id());
			obj.put("restaurant_order", dto.getRestaurant_order());
			obj.put("latitude", dto.getLatitude());
			obj.put("longitude", dto.getLongitude());
			jsonArray.add(obj);
		}
		
		JSONObject objFinal = new JSONObject();
		objFinal.put("result", jsonArray);
		//System.out.println(objFinal);
		
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.println(objFinal);
	}
}
