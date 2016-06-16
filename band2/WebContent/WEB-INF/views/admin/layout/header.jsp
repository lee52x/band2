<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	String cp=request.getContextPath();
%>
        <!-- top navigation -->
        <div class="top_nav">

          <div class="nav_menu">
            <nav class="" role="navigation">
            
              <div class="nav toggle">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>
              </div>
              
              <ul class="nav navbar-nav navbar-right">
              
                <li role="presentation" class="dropdown">
                
                  <a href="<%=cp%>/group/${url}" class="dropdown-toggle info-number">
                    ${sessionScope.main.userName}님&nbsp;&nbsp;<i class="fa fa-power-off"></i> LOGOUT
                  </a>
                </li>

              </ul>
            </nav>
          </div>

        </div>
        <!-- /top navigation -->        
 
