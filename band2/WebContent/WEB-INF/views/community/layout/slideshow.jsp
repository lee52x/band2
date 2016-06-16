<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>


    <!-- Start : SlideShow -->
	<div id="carousel-example-generic" class="carousel slide carousel-fade" data-ride="carousel">
               <!-- Indicators -->
               <ol class="carousel-indicators">
                  <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                  <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                  <li data-target="#carousel-example-generic" data-slide-to="2"></li>
               </ol>
               <!-- Wrapper for slides -->
               <div class="carousel-inner" role="listbox">
                  <div class="item active" style="background-repeat:no-repeat; background-image: url(<%=cp%>/uploads/management/${pdto.saveFilename});
                     background-size: 100%;">
                     <div class="carousel-caption">
           	           <h3 style="font-weight: bold;">${sessionScope.main.groupName}</h3>
                        <p>${sessionScope.main.introduce}</p>
                     </div>
                  </div>
               	<c:forEach items="${plist}" var="pdto2">
               		<div class="item" style="background-image: url(<%=cp%>/uploads/management/${pdto2.saveFilename}); background-repeat:no-repeat;
               		 background-size: 100% 400px;">
               			<div class="carousel-caption">
                        	<h3 style="font-weight: bold;">${sessionScope.main.groupName}</h3>
                        	<p>${sessionScope.main.introduce}</p>
                     	</div>
                  	</div>
               	</c:forEach>
               </div>
               <!-- Controls -->
               <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
               <span class="fa fa-chevron-left" aria-hidden="true" style="padding-top:200px;"></span>
               <span class="sr-only">Previous</span>
               </a>
               <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
               <span class="fa fa-chevron-right" aria-hidden="true" style="padding-top:200px;"></span>
               <span class="sr-only">Next</span>
               </a>
    </div>
    <!-- End : SlideShow -->