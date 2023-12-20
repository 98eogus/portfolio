<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<body>

<h2>commentTest</h2>
comment: <input type="text" name="comment"/>
<button id="sendBtn" type="button">SEND</button>
<button id="modBtn" type="button">수정</button>
<div id="commentList"></div>
<div id="replyForm" style="display: none">
    <input type="text" name="replyComment">
    <button id="wrtRepBtn" type="button">등록</button>
</div>
<script>
    let bno = 1156;

    let showList = function(bno){
        $.ajax({
            type:'GET',       // 요청 메서드
            url: '/project/comments?bno='+bno,  // 요청 URI
            dataType : 'json', // 전송받을 데이터의 타입
            success : function(result){
                $("#commentList").html(toHtml(result));    // 서버로부터 응답이 도착하면 호출될 함수

            },
            error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
        }); // $.ajax()
    }

    $(document).ready(function(){
        showList(bno);

        $("#wrtRepBtn").click(function(){

            let comment =$("input[name=replyComment]").val();
            let pcno = $("#replyForm").parent().attr("data-pcno");
            if(comment.trim()==''){
                alert("답글을 입력해 주세요");
                $("input[name=replyComment]").focus()
                return;
            }

            $.ajax({
                type:'POST',       // 요청 메서드
                url: '/project/comments?bno='+bno , // 요청 URI
                headers : { "content-type": "application/json"}, // 요청 헤더
                data : JSON.stringify({pcno:pcno, bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                success : function(result){
                    alert(result);
                    showList(bno)
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()
            $("#replyForm").css("display","none");
            $("input[name=replyComment]").value('')
            $("#replyForm").appendTo("body");
        });

        $("#modBtn").click(function(){
            let cno = $(this).attr("data-cno");
            let comment =$("input[name=comment]").val();

            if(comment.trim()==''){
                alert("댓글을 입력해 주세요");
                $("input[name=comment]").focus()
                return;
            }

            $.ajax({
                type:'PATCH',       // 요청 메서드
                url: '/project/comments/'+cno,  // 요청 URI
                headers : { "content-type": "application/json"}, // 요청 헤더
                data : JSON.stringify({cno:cno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                success : function(result){
                    alert(result);
                    showList(bno)
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()
         });

            $("#sendBtn").click(function(){

                let comment =$("input[name=comment]").val();
                if(comment.trim()==''){
                    alert("댓글을 입력해 주세요");
                    $("input[name=comment]").focus()
                    return;
                }

                $.ajax({
                    type:'POST',       // 요청 메서드
                    url: '/project/comments?bno='+bno , // 요청 URI
                    headers : { "content-type": "application/json"}, // 요청 헤더
                    data : JSON.stringify({bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                    success : function(result){
                        alert(result);
                        showList(bno)
                    },
                    error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
                }); // $.ajax()
            });

        $("#commentList").on("click",".modBtn",function() {
            let cno = $(this).parent().attr("data-cno");
            let bno = $(this).parent().attr("data-bno");
            let comment = $("span.comment",$(this).parent()).text();
            //1. comment의 내용을 input에 뿌려주기

            $("input[name=comment]").val(comment);
            //2. cno전달하기
            $("#modBtn").attr("data-cno",cno);
        });

        $("#commentList").on("click",".replyBtn",function() {

            //1. reply폼을 옮기고
            $("#replyForm").appendTo($(this).parent());

            //2. 답글을 입력할 폼을 보여주기
            $("#replyForm").css("display","block");

        });

        //$(".delBtn").click(function(){
        $("#commentList").on("click",".delBtn",function(){
            let cno = $(this).parent().attr("data-cno");
            let bno = $(this).parent().attr("data-bno");
            $.ajax({
                type:'DELETE',       // 요청 메서드
                url: '/project/comments/'+cno+'?bno='+bno,  // 요청 URI

                success : function(result){
                    alert(result)
                    showList(bno)
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()

        });
    });




</script>
</body>
</html>