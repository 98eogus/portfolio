<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false"%>
<c:set var="loginId" value="${pageContext.request.session.getAttribute('id')==null ? '' : pageContext.request.session.getAttribute('id')}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'Logout'}"/>
<!DOCTYPE html>
<html>

<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>




<blockquote>
    <h1> Spring + Mysql(USER and Board and Reply)</h1>
    <br>
    <br>


    <h4>
        <p>1. 주요기능 </p>
        &nbsp;&nbsp; 1) 회원관리(로그인 / 로그아웃 / 회원가입) - user_info Table <br>
        &nbsp;&nbsp; 2) 자유게시판(등록, 수정, 삭제, 검색) - board Table<br>
        &nbsp;&nbsp; 3) 댓글(등록, 삭제) - comment Table<br>
        &nbsp;&nbsp; 4) 배너 - banner Table<br>
        <br>
        <p>2. 주요 기술 및 환경</p>
        &nbsp;&nbsp;1) Spring WEB MVC구조  <br>
        &nbsp;&nbsp;2) Spring Data Mybatis <br>
        &nbsp;&nbsp;3) Spring AOP  - Session유무 체크 <br>
        &nbsp;&nbsp;&nbsp;&nbsp; : Board에 대한 접근은 인증된 사용자만 가능<br>
        &nbsp;&nbsp;4) Action Tag include - Layout Template  <br>
        &nbsp;&nbsp;5) mysql <br>
        &nbsp;&nbsp;6) 게시판 paging처리 <br>
        &nbsp;&nbsp;7) Ajax로 댓글, 배너구현 <br>
        <br>
        <br>
        <br>
        <br>


    </h4>

</blockquote>

</body>

<footer>
    <style>
        /* 배너 스타일 */
        .banner {
            background-color: #3498db; /* 배너 배경색 */
            color: #fff; /* 글자색 */
            padding: 15px; /* 패딩 */
            text-align: center; /* 텍스트 가운데 정렬 */
        }
    </style>

</footer>
<!-- 배너 영역 시작 -->

<div class="banner">
    <h2 id="bannerText"></h2>
</div>
<!-- 배너 영역 끝 -->

<script src="https://code.jquery.com/jquery-1.11.3.js"></script>
<script type="text/javascript">
    let msg = "${msg}";
    if(msg=="REG_OK")  alert("회원가입 성공");
    if(msg=="REG_ERR")  alert("회원가입 실패");
    let bannerIndex=0;
    let bannerList=[];

    function getBanner(contextPath){
        let banner = $(".banner");

        //서버와 통신
        $.ajax({
            url:contextPath+"/banners",
            type:"get",
            dataType:"json",
            success: function(result){

                bannerList = result;

                let bannerText = bannerList[bannerIndex++];
                $("#bannerText").text(bannerText);
                setInterval(function(){
                    let bannerText = bannerList[bannerIndex++];
                    $("#bannerText").text(bannerText);

                    if(bannerIndex==bannerList.length) bannerIndex=0;


                }, 2500);

            },
            error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수


        });

    }// getBannerEnd

    /////////////////////////////////////////


    $(function(){

        //banner가져오기
        getBanner("${pageContext.request.contextPath}");

    });//ready끝


</script>

</html>