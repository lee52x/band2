<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp = request.getContextPath();
%>

<link href="<%=cp%>/res/css/admin/custom.css" rel="stylesheet">

<div class="col-md-12 col-sm-12 col-xs-12">
	<div class="x_panel">
		<!-- Start Hello -->
		<div class="x_panel">
			<div class="x_content">
				<div class="bs-example" data-example-id="simple-jumbotron">
					<div class="jumbotron">
						<h1>안녕하세요!!!</h1>
						<p>쌍용대학교 개발동아리 관리자 페이지입니다.</p>
					</div>
				</div>
			</div>
		</div>
		<!-- End Hello -->

		<!-- Start to do list -->
		<div class="x_panel">
			<div class="x_title">
				<h2>
					To Do List <small>Sample tasks</small>
				</h2>
				<div class="clearfix"></div>
			</div>
			<div class="x_content">

				<div class="">
					<ul class="to_do">
						<li>
							<p>
								<input type="checkbox" class="flat"> Schedule meeting
								with new client
							</p>
						</li>
						<li>
							<p>
								<input type="checkbox" class="flat"> Create email
								address for new intern
							</p>
						</li>
						<li>
							<p>
								<input type="checkbox" class="flat"> Have IT fix the
								network printer
							</p>
						</li>
						<li>
							<p>
								<input type="checkbox" class="flat"> Copy backups to
								offsite location
							</p>
						</li>
						<li>
							<p>
								<input type="checkbox" class="flat"> Food truck fixie
								locavors mcsweeney
							</p>
						</li>
						<li>
							<p>
								<input type="checkbox" class="flat"> Food truck fixie
								locavors mcsweeney
							</p>
						</li>
					</ul>
				</div>
			</div>
		</div>
		<!-- End to do list -->

	</div>
</div>
<div class="clearfix"></div>