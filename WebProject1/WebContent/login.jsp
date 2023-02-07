<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <!DOCTYPE html>
    <html lang="kor">
    <head>
    	<link rel="icon" href="Images/profile/mango_favicon.png">
        <script src="https://code.jquery.com/jquery-3.6.1.js"
            integrity="sha256-3zlB5s2uwoUzrXK3BT7AX3FyvojsraNFxCc2vC/7pNI=" crossorigin="anonymous"></script>
        <meta charset="UTF-8">
        <!-- <meta http-equiv="X-UA-Compatible" content="IE=edge"> -->
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>mango_Login</title>
        <style>
            .img {animation: rotate_image 6s linear infinite;transform-origin: 50% 50%;}
    
    @keyframes rotate_image{
        100% {
            transform: rotate(360deg);
        }
    }
        button{
            appearance: none;
        }
        a{
            appearance: none;
    
        }
        </style>
        <script>
        function go_join(){
            location.href="join_member.jsp";
        }
        </script>
    </head>
    <body style="margin: 10px 0 0 0;">
        
    
        <header style="margin-bottom: 30px;">
            <div style= "margin: 0 auto; width: 421px; height: 132px; text-align: center; color: rgb(238, 110, 12); font-size: 60px; background-image: url(Images/logo.png);"  >
                <img class="img" style="margin-top: 80px ; margin-right: 500px;" src="img/P_Real.png" alt="">
               <!-- <b>회원가입</b> -->
            </div>
        </header>
    	<form method="get" action="login_Action.jsp">
            <main style="background-image: url(Images/mango_back.png); background-size: 100%;">
                <div style="background-color: rgb(238, 110, 12); height: 30px;">
                </div>
           <div style=" padding-top: 50px; width: 500px; font-size: 15px;  margin : 0 auto; height: 650px; background-color: rgb(250, 246, 236);">
            <div style=" margin: 0 50px 10px;">
                <div style="margin-bottom: 30px;">
                    <div style="margin-bottom: 10px;">
                        <b>이메일</b>
                    </div>
               <div>
                   <input style="margin: 10 0px; width: 400px; height: 30px;" type="text" placeholder="Email" name="email" />
               </div>
            </div>
            <div>
                <div style="margin-bottom: 10px;">
                    <b>비밀번호</b>
    
                </div>
               <input style="margin-bottom: 20px; width: 400px; height: 30px;" type="password" placeholder="Password" name="passw" />
            </div>
               
    
            
            <div style="text-align: center; margin-top: 40px;">
                <input style="padding: 5px; border-radius: 6px; width: 400px; border : 0;
                 height: 30px; background-color: rgb(238, 110, 12); color: rgb(246, 255, 255);" type="submit" value="로그인" >
            </div>
            </div>
    	</form>
            <div style="text-align: center; font-size: 13px; color: rgb(172, 136, 104); margin-bottom: 30px;">
                <span style="border-right: 1px solid rgb(248, 222, 222); margin: 0 10px 0 0; padding-right: 10px;">이메일 찾기</span>
                <span style="border-right: 1px solid rgb(248, 222, 222); margin: 0 10px 0 0; padding-right: 10px;">비밀번호 찾기</span>
                <div onclick="go_join()" style="cursor: pointer; display: inline-block;">회원가입</div>
                
            </div>
            <div style="margin: 30px; border-top: solid rgb(248, 222, 222); padding: 20px;">
                <div style="height: 51px; width: 256px; border-radius: 48px; background-color: rgb(29, 194, 0); margin: 0 auto; margin-bottom: 20px;">
                    <div style="background-image: url(Images/naver.PNG);background-size: 40px; width: 30px; height: 30px; background-position: 50% 50%; margin: 10px ; position: absolute;">
                    </div>
                    <div style="color: white; margin: 15px 0 0 70px; display: inline-block;">
                        <span>네이버계정으로 로그인</span>
                    </div>
                    </div>
                <div style=" height: 51px; width: 256px; border-radius: 48px; background-color: rgb(60, 90, 152); margin: 0 auto; margin-bottom: 20px;">
                    <div style="background-image: url(Images/face.PNG); background-size: 41px; width: 30px; height: 30px; margin: 10px ; position: absolute;">
                    </div>
                    <div style="color: white; margin: 15px 0 0 70px; display: inline-block;">
                        <span>페이스북으로 로그인</span>
                    </div>
                </div>
                <div style="height: 51px; width: 256px; border-radius: 48px; background-color: #ffe809; margin: 0 auto; margin-bottom: 20px;">
                    <div style="background-image: url(Images/kakao.PNG);background-size: 30px; width: 30px; height: 29px; background-position: 50% 50%; margin: 10px ; position: absolute;">
                    </div>
                    <div style="color: rgb(82, 46, 46); margin: 15px 0 0 70px; display: inline-block;">
                        <span>카카오계정으로 로그인</span>
                    </div>
                </div>
                <div style="height: 51px; width: 256px; border-radius: 48px; background-color: #000000; margin: 0 auto; margin-bottom: 20px;">
                    <div style="background-image: url(Images/apple.svg);background-size: 30px; width: 30px; height: 30px; background-position: 50% 50%; margin: 10px ; position: absolute;">
                    </div>
                    <div style="color: white; margin: 15px 0 0 70px; display: inline-block;">
                        <span>애플계정으로 로그인</span>
                    </div>
                    </div>
                
    
            </div>
    
    
    
    
           </div>
    
    
        </main>
    
    
    </body>
    </html>