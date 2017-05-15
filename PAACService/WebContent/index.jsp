<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script src="<%=request.getContextPath()%>/resources/plugins/jQuery/jquery-2.2.3.min.js"></script>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script>
   
    function test()
    {
    	alert('test');
    	jQuery.ajax({
			url : 'workflow-getapproverstep',
			type : "Post",
			contentType : "application/json",
			dataType : 'json',
			success : function(data) {
				alert("success");
			},
			error : function() {

				alert("false");

			}
		});
    	alert('test2');
    }
    </script>
</head>
<body>
<input type="button" onclick="test();"/>

</body>
</html>