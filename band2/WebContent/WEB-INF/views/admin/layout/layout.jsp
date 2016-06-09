<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<%
	String cp=request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link href="<%=cp%>/res/css/bootstrap.css" rel="stylesheet">
    <link href="<%=cp%>/res/css/font-awesome/css/font-awesome.css" rel="stylesheet">
            
    <script src="<%=cp%>/res/js/jquery.js"></script>
    
    <style type="text/css">
    </style>
</head>
 <body class="nav-md">
    <div class="container body">
      <div class="main_container">        
		<div>
			<tiles:insertAttribute name="header" />
		</div>

		<div>
			<tiles:insertAttribute name="left" />
		</div>

        <!-- page content -->
        <div class="right_col" role="main">
        	<div>
        		<tiles:insertAttribute name="body" />
        	</div>
        </div>
                
      </div>
    </div>

    <script src="<%=cp%>/res/js/admin/custom.js"></script>    
    <script src="<%=cp%>/res/js/bootstrap.js"></script>   
  </body>
</html>