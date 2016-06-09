<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>


		<!-- Start : Board List -->
        
            <div class="container-fluid">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">Our Group Bulletin Board</h4>
                                <p class="category">Here is a subtitle for this table</p>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover table-striped">
                                    <thead>
                                        <th style="width:calc(10%);">Num</th>
                                    	<th style="width:calc(60%);">Subject</th>
                                    	<th style="width:calc(15%);">Date</th>
                                    	<th style="width:calc(10%);">Count</th>
                                    	<th style="width:calc(5%);">File</th>
                                    </thead>
                                    <tbody>
                                        <tr>
                                        	<td>1</td>
                                        	<td><a href="#">Subject 1</a></td>
                                        	<td>2016-05-10</td>
                                        	<td>0</td>
                                        	<td><a href="#"></a></td>
                                        </tr>
                                        <tr>
                                        	<td>2</td>
                                        	<td><a href="#">Subject 2</a></td>
                                        	<td>2016-05-10</td>
                                        	<td>10</td>
                                        	<td><a href="#"></a></td>
                                        </tr>
                                        <tr>
                                        	<td>3</td>
                                        	<td><a href="#">Subject 3</a></td>
                                        	<td>2016-05-10</td>
                                        	<td>16</td>
                                        	<td><a href="#"></a></td>
                                        </tr>
                                        <tr>
                                        	<td>4</td>
                                        	<td><a href="#">Subject 4</a></td>
                                        	<td>2016-05-10</td>
                                        	<td>12</td>
                                        	<td><a href="#"></a></td>
                                        </tr>
                                        <tr>
                                        	<td>5</td>
                                        	<td><a href="#">Subject 5</a></td>
                                        	<td>2016-05-10</td>
                                        	<td>10</td>
                                        	<td><a href="#"><img style="width:14px; height:14px;" src="<%=cp%>/res/img/community/disk.png"></a></td>
                                        </tr>
                                        <tr>
                                        	<td>6</td>
                                        	<td><a href="#">Subject 6</a></td>
                                        	<td>2016-05-10</td>
                                        	<td>72</td>
                                        	<td><a href="#"></a></td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                        <div class="card">
                            <div class="header">
                                <h4 class="title">공 지 사 항</h4>
                                <p class="category">공지사항 임시 테이블</p>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover table-striped">
                                    <thead>
                                        <th style="width:calc(10%);">공지 번호</th>
                                    	<th style="width:calc(60%);">공지 내용</th>
                                    	<th style="width:calc(15%);">공지 날짜</th>
                                    </thead>
                                    <tbody>
                                    	<c:forEach items="${nlist}" var="vo">
                                       		<tr>
                                        		<td>${vo.listNum}</td>
                                        		<td>${vo.content}</td>
                                        		<td>${vo.created}</td>
                                        	</tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        
                    </div>
                </div>
            </div>
        <!-- End : Board List -->