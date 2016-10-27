<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="app" value="${pageContext.servletContext.contextPath}" />
<sec:authorize access="isAuthenticated()" var="userKnown"></sec:authorize>
<c:if test="${userKnown}">
	<sec:authentication property="name" var="currentUsername"></sec:authentication>
</c:if>

<nav class="navbar navbar-default navbar-fixed-top">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="${app}/">ERP</a>
			<c:if test="${userKnown}">
				<button type="button"
						class="navbar-toggle collapsed"
						data-toggle="collapse"
						data-target="#hd-main-nav">
				
					<i class="fa fa-bars"></i>
				</button>
			</c:if>
		</div>

		<c:if test="${userKnown}">
			<div class="collapse navbar-collapse" id="hd-main-nav">
				<ul class="nav navbar-nav navbar-right">
					<sec:authorize access="hasAuthority('VIEW_ADMIN_MENU')">
						<li class="dropdown">
							<a href="#" class="dropdown-toggle" data-toggle="dropdown">
								<i class="fa fa-cog"></i>
								<span class="caret"></span>
							</a>
							<ul class="dropdown-menu">
								<sec:authorize access="hasAuthority('VIEW_ROLES_PAGE')">
									<li>
										<a href="${app}/admin/roles">Roles</a>
									</li>
								</sec:authorize>
								<sec:authorize access="hasAuthority('VIEW_USERS_PAGE')">
									<li>
										<a href="${app}/admin/users">Users</a>
									</li>
								</sec:authorize>
							</ul>
						</li>
					</sec:authorize>
					<li class="dropdown">
						<a href="#" class="dropdown-toggle" data-toggle="dropdown">
							${currentUsername} <span class="caret"></span>
						</a>
						<ul class="dropdown-menu">
							<li><a href="${app}/profile"><i class="fa fa-user"></i> ${loggedUserName}</a></li>
							<li><a href="${app}/signout" id="hd-signout-link"><i class="fa fa-sign-out"></i> Sign Out</a></li>
						</ul>
					</li>
				</ul>
			</div>
		</c:if>
	</div>
</nav>

<section class="hd-alerts"></section>