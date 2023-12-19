<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ page session="true"%>
<c:set var="loginId" value="${sessionScope.id}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'ID='+=loginId}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <jsp:include page="/WEB-INF/views/common/header.jsp"/>
    <style>


        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR", sans-serif;
        }

        .container {
            width : 50%;
            margin : auto;
            margin-bottom: 100px; /* 페이지 하단 여백을 늘려 스크롤이 가려지지 않도록 함 */
        }

        body {
            overflow-y: scroll; /* 수직 스크롤바를 항상 표시 */
        }


        .writing-header {
            position: relative;
            margin: 20px 0 0 0;
            padding-bottom: 10px;
            border-bottom: 1px solid #323232;
        }

        input {
            width: 100%;
            height: 35px;
            margin: 5px 0px 10px 0px;
            border: 1px solid #e9e8e8;
            padding: 8px;
            background: #f8f8f8;
            outline-color: #e6e6e6;
        }

        textarea {
            width: 100%;
            background: #f8f8f8;
            margin: 5px 0px 10px 0px;
            border: 1px solid #e9e8e8;
            resize: none;
            padding: 8px;
            outline-color: #e6e6e6;
        }

        .frm {
            width:100%;
        }
        .btn {
            background-color: rgb(236, 236, 236); /* Blue background */
            border: none; /* Remove borders */
            color: black; /* White text */
            padding: 6px 12px; /* Some padding */
            font-size: 16px; /* Set a font size */
            cursor: pointer; /* Mouse pointer on hover */
            border-radius: 5px;
        }

        .btn:hover {
            text-decoration: underline;
        }

        /**/



        #commentList {
            width : 100%;
            margin : auto;
        }

        .comment-content {
            overflow-wrap: break-word;
        }

        .comment-bottom {
            font-size:9pt;
            color : rgb(97,97,97);
            padding: 8px 0 8px 0;
        }

        .comment-bottom > a {
            color : rgb(97,97,97);
            text-decoration: none;
            margin : 0 6px 0 0;
        }

        .comment-area {
            padding : 0 0 0 46px;
        }

        .commenter {
            font-size:12pt;
            font-weight:bold;
        }

        .commenter-writebox {
            padding : 15px 20px 20px 20px;
        }

        .comment-img {
            font-size:36px;
            position: absolute;
        }

        .comment-item {
            position:relative;
            margin-top: 20px;
        }

        .up_date {
            margin : 0 8px 0 0;
        }

        #comment-writebox {
            background-color: white;
            border : 1px solid #e5e5e5;
            border-radius: 5px;
            margin-top: 20px; /* 여백 추가 */
        }



        #comment-writebox-bottom {
            padding : 3px 10px 10px 10px;
            min-height : 35px;

        }



        #btn-write-comment, #btn-write-reply {
            color : #009f47;
            background-color: #e0f8eb;
        }

        #btn-cancel-reply {
            background-color: #eff0f2;
            margin-right : 10px;
        }

        #btn-write-modify {
            color : #009f47;
            background-color: #e0f8eb;
        }

        #btn-cancel-modify {
            margin-right : 10px;
        }

        #reply-writebox {
            display : none;
            background-color: white;
            border : 1px solid #e5e5e5;
            border-radius: 5px;
            margin : 10px;
        }

        #reply-writebox-bottom {
            padding : 3px 10px 10px 10px;
            min-height : 35px;
        }

        #modify-writebox {
            background-color: white;
            border : 1px solid #e5e5e5;
            border-radius: 5px;
            margin : 10px;
        }

        #modify-writebox-bottom {
            padding : 3px 10px 10px 10px;
            min-height : 35px;
        }

        /* The Modal (background) */
        .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            padding-top: 100px; /* Location of the box */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }

        /* Modal Content */
        .modal-content {
            background-color: #fefefe;
            margin: auto;
            padding: 20px;
            border: 1px solid #888;
            width: 50%;
        }

        /* The Close Button */
        .close {
            color: #aaaaaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }

        .close:hover,
        .close:focus {
            color: #000;
            text-decoration: none;
            cursor: pointer;
        }




    </style>

</head>
<body>

<script>
    let msg = "${msg}";
    if(msg=="WRT_ERR") alert("게시물 등록에 실패하였습니다. 다시 시도해 주세요.");
    if(msg=="MOD_ERR") alert("게시물 수정에 실패하였습니다. 다시 시도해 주세요.");
</script>
<div class="container">
    <h2 class="writing-header">게시판 ${mode=="new" ? "글쓰기" : "읽기"}</h2>
    <form id="form" class="frm" action="" method="post">
        <input type="hidden" name="bno" value="${boardDto.bno}">

        <input name="title" type="text" value="${boardDto.title}" placeholder="  제목을 입력해 주세요." ${mode=="new" ? "" : "readonly='readonly'"}><br>
        <textarea name="content" rows="20" placeholder=" 내용을 입력해 주세요." ${mode=="new" ? "" : "readonly='readonly'"}>${boardDto.content}</textarea><br>

        <c:if test="${mode eq 'new'}">
            <button type="button" id="writeBtn" class="btn btn-write"><i class="fa fa-pencil"></i> 등록</button>
        </c:if>
        <c:if test="${mode ne 'new'}">
            <button type="button" id="writeNewBtn" class="btn btn-write"><i class="fa fa-pencil"></i> 글쓰기</button>
        </c:if>
        <c:if test="${boardDto.writer eq loginId}">
            <button type="button" id="modifyBtn" class="btn btn-modify"><i class="fa fa-edit"></i> 수정</button>
            <button type="button" id="removeBtn" class="btn btn-remove"><i class="fa fa-trash"></i> 삭제</button>
        </c:if>
        <button type="button" id="listBtn" class="btn btn-list"><i class="fa fa-bars"></i> 목록</button>
    </form>


    <c:if test="${mode ne 'new'}">

        <div id="commentList">

            <div id="comment-writebox">
                <div class="commenter commenter-writebox">${id}</div>
                <div class="comment-writebox-content">
                    <textarea name="comment" id="" cols="30" rows="3" placeholder="댓글을 남겨보세요"></textarea>
                </div>
                <div id="comment-writebox-bottom">
                    <div class="register-box" style="display: flex; justify-content: flex-end;">
                        <a href="#" class="btn" id="btn-write-comment">등록</a>
                    </div>
                </div>
            </div>
        </div>


    </c:if>

</div>



<script>
    let bno = ${boardDto.bno};

    let showList = function(bno){
        $.ajax({
            type:'GET',       // 요청 메서드
            url: '${pageContext.request.contextPath}/comments?bno='+bno,  // 요청 URI
            dataType : 'json', // 전송받을 데이터의 타입
            success : function(result){
                var commentList = result;

                for (var i = 0; i < commentList.length; i++) {
                    if (commentList[i].pcno == commentList[i].cno) {
                        // 새로운 댓글 항목을 만듭니다.
                        var commentItem = $("<div>").addClass("comment-item")
                            .attr("data-cno", commentList[i].cno)  // 필요에 따라 값을 조정하세요.
                            .attr("data-bno", bno);

                        // 댓글 이미지 추가
                        var commentImg = $("<span>").addClass("comment-img")
                            .html('<i class="fa fa-user-circle" aria-hidden="true"></i>');
                        commentItem.append(commentImg);

                        // 댓글 영역 추가
                        var commentArea = $("<div>").addClass("comment-area");

                        // 댓글 작성자 추가 (여기서는 임의의 값인 "asdf"를 사용)
                        var commenter = $("<div>").addClass("commenter").text(commentList[i].commenter);
                        commentArea.append(commenter);

                        // 댓글 내용 추가
                        var commentContent = $("<div>").addClass("comment-content");
                        commentContent.text(commentList[i].comment);
                        commentArea.append(commentContent);

                        // 댓글 하단 영역 추가
                        var commentBottom = $("<div>").addClass("comment-bottom");

                        // 날짜 추가
                        // 가정: commentList[i].up_date는 밀리초 단위의 타임스탬프입니다.
                        var timestamp = commentList[i].up_date;
                        var date = new Date(timestamp);

                        // 날짜를 "YYYY.MM.DD HH:mm:ss" 형식으로 포맷합니다.
                        var formattedDate = date.getFullYear() + "." +
                            ("0" + (date.getMonth() + 1)).slice(-2) + "." +
                            ("0" + date.getDate()).slice(-2) + " " +
                            ("0" + date.getHours()).slice(-2) + ":" +
                            ("0" + date.getMinutes()).slice(-2) + ":" +
                            ("0" + date.getSeconds()).slice(-2);

                        // 포맷된 날짜로 span 엘리먼트를 생성합니다.
                        var upDate = $("<span>").addClass("up_date").text(formattedDate);
                        commentBottom.append(upDate);

                        // 버튼들 추가
                        var btnWrite = $('<a href="#" class="btn-write" data-cno="' + commentList[i].cno + '" data-bno="' + bno + '" data-pcno="' + commentList[i].pcno + '">답글쓰기</a>');
                        var btnModify = $('<a href="#" class="btn-modify" data-cno="' + commentList[i].cno + '" data-bno="' + bno + '" data-pcno="' + commentList[i].pcno + '">수정</a>');
                        var btnDelete = $('<a href="#" class="btn-delete" data-cno="' + commentList[i].cno + '" data-bno="' + bno + '" data-pcno="' + commentList[i].pcno + '">삭제</a>');

                        commentBottom.append(btnWrite, btnModify, btnDelete);

                        // 댓글 영역에 하단 영역 추가
                        commentArea.append(commentBottom);

                        // 댓글 항목을 컨테이너에 추가
                        $(".container").append(commentItem.append(commentArea));
                    }
                }
            },

            error : function(){ alert(result) } // 에러가 발생했을 때, 호출될 함수
        }); // $.ajax()
    }

    $(document).ready(function(){
        showList(bno);
        let formCheck = function() {
            let form = document.getElementById("form");
            if(form.title.value=="") {
                alert("제목을 입력해 주세요.");
                form.title.focus();
                return false;
            }

            if(form.content.value=="") {
                alert("내용을 입력해 주세요.");
                form.content.focus();
                return false;
            }
            return true;
        }

        $("#writeNewBtn").on("click", function(){
            location.href="<c:url value='/board/write'/>";
        });

        $("#writeBtn").on("click", function(){
            let form = $("#form");
            form.attr("action", "<c:url value='/board/write'/>");
            form.attr("method", "post");

            if(formCheck())
                form.submit();
        });

        $("#modifyBtn").on("click", function(){
            let form = $("#form");
            let isReadonly = $("input[name=title]").attr('readonly');

            // 1. 읽기 상태이면, 수정 상태로 변경
            if(isReadonly=='readonly') {
                $(".writing-header").html("게시판 수정");
                $("input[name=title]").attr('readonly', false);
                $("textarea").attr('readonly', false);
                $("#modifyBtn").html("<i class='fa fa-pencil'></i> 등록");
                return;
            }

            // 2. 수정 상태이면, 수정된 내용을 서버로 전송
            form.attr("action", "<c:url value='/board/modify${searchCondition.queryString}'/>");
            form.attr("method", "post");
            if(formCheck())
                form.submit();
        });

        $("#removeBtn").on("click", function(){
            if(!confirm("정말로 삭제하시겠습니까?")) return;

            let form = $("#form");
            form.attr("action", "<c:url value='/board/remove${searchCondition.queryString}'/>");
            form.attr("method", "post");
            form.submit();
        });

        $("#listBtn").on("click", function(){
            location.href="<c:url value='/board/list${searchCondition.queryString}'/>";
        });



        //**************댓글 등록하기

        $("#btn-write-comment").click(function(){

            let comment =$("textarea[name=comment]").val();
            if(comment.trim()==''){
                alert("댓글을 입력해 주세요");
                $("textarea[name=comment]").focus()
                return;
            }

            $.ajax({
                type:'POST',       // 요청 메서드
                url: '${pageContext.request.contextPath}/comments?bno='+bno , // 요청 URI
                headers : { "content-type": "application/json"}, // 요청 헤더
                data : JSON.stringify({bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                success : function(result){
                    alert(result);
                    $("textarea[name=comment]").val('');
                   showList(bno);
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()
        });

    });

    let toHtml = function (comments) {
        let tmp = "<ul>";

        comments.forEach(function (comment){
            tmp+='<li data-cno=' + comment.cno
            tmp+=' data-pcno=' + comment.pcno
            tmp+=' data-bno=' + comment.bno + '>'
            if(comment.cno!=comment.pcno)
                tmp+='ㄴ'
            tmp+=' commenter=<span class ="commenter">' + comment.commenter + '</span>'
            tmp+=' comment=<span class ="comment">' + comment.comment + '</span>'
            tmp+=' up_date='+comment.up_date
            tmp+=' <button class="delBtn">삭제</button>'
            tmp+=' <button class="modBtn">수정</button>'
            tmp+=' <button class="replyBtn">답글</button>'
            tmp+='</li>'
        })

        return tmp + "</ul>"

    }






</script>

</body>

</html>