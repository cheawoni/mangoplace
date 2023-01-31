<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.yg.dto.*"%>

<%!
	private Connection getConnection() {
		Connection conn = null;
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String dbId = "test1017";
		String dbPw = "1234";
		
		try {
			Class.forName(driver);
			System.out.println("JDBC 드라이버 로딩 성공");
			conn = DriverManager.getConnection(url, dbId, dbPw);
			System.out.println("접속성공");
		} catch(Exception e) {
			e.printStackTrace();
			System.out.println("오라클 접속 실패");
		}
		return conn;
	}
	public ArrayList<BoardDTO> getAllBoardList() throws Exception {
		Connection conn = getConnection();
		ArrayList<BoardDTO> listBoard = new ArrayList<BoardDTO>();
		
		String sql = "SELECT * FROM simple_board ORDER BY bno DESC";
		
		PreparedStatement pstmt = conn.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while(rs.next()) {
			int bno = rs.getInt("bno");
			String title = rs.getString("title");
			String content = rs.getString("content");
			String writer = rs.getString("writer");
			String writedate = rs.getString("writedate");
			listBoard.add(new BoardDTO(bno, writer, title, content, writedate));   //(bno, title, content, writer, writedate));
		}
		rs.close();
		pstmt.close();
		conn.close();
		return listBoard;
	}
%>
<%
ArrayList<BoardDTO> listB = getAllBoardList();
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>전체 게시글 출력</title>
	<script src="../js/jquery-3.6.3.min.js"></script>
	<style>
		table {
			border-collapse: collapse; 
		}
		td {
			border: 1px solid grey;
			padding: 10px;
		}
	</style>
	<script>
/* 		function btn_write_clicked() {
			alert("!");
			location.href = "https://www.naver.com";
		}
 */		
		$(function() {
			$("#btn_write").click(function() {
				location.href = "Ex10Write.jsp";
			});
			$("table tr").click(function() {
				var bno = $(this).find("td.bno").text();
				$.ajax({
					type: "get",
					url: "../Ex15Servlet",
					data: {"bno":bno},
					datatype: "json",
					success: function(data) {	// 무한스크롤 append
						//alert("서버로부터 받은 데이터 data.result=" + data.result);
						$(".bno").each(function(index, item) {
							//console.log( $(item).text() );
							if( $(item).text()==bno ) {
								var t = $(item).parent().find(".title").text();
								$(item).parent().find(".title").text(t+"!");
							}
						});
					},
					error: function(r,s,e) {	// Ex13.jsp 참고.
						alert("에러!");
					}
				});
			});
		});
	</script>
</head>
<body>
	<table>
		<tr>
			<th>글 번호</th>
			<th>제목</th>
			<th>작성자</th>
			<th>작성일시</th>
		</tr>
		<% 
			for(BoardDTO board : listB) { 
		%>
			<tr>
				<td class="bno"><%=board.getBno() %></td>
				<td class="title"><%=board.getTitle() %></td>
				<td><%=board.getWriter() %></td>
				<td><%=board.getWritedate() %></td>
			</tr>
		<% 
			} 
		%>
	</table>
	<!-- <button onclick="btn_write_clicked()">글쓰기</button> -->
	<!-- <a href="https://www.naver.com">글쓰기</a> -->
	<button id="btn_write">글쓰기</button>
</body>
</html>


