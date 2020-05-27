<%--
  Created by IntelliJ IDEA.
  User: Dell
  Date: 2020/5/20
  Time: 11:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
</head>
<body>
<script >
    function a1() {
        $.post({
            url: "${pageContext.request.contextPath}/ajax/a1",
            data: {'name':$("#txtName").val()},
            success:function (data) {
               alert(data);
            }
    })
        //将文本的输出的值，

        // 发给服务器，

        // 接受服务器返回的数据。



    }
</script>
用户名：
<input type="text" id="txtName" onblur="a1()">
</body>
</html>
