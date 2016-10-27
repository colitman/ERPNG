<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="app" value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html lang="en">
	<head>
		<c:import url="/imports/head?pageTitle=${user.username} :: Profile"></c:import>
	</head>
	
	<body data-page="profile" data-target="${username}">
		<div class="container">
			<c:import url="/imports/mainNav?root=false"></c:import>
			<header class="hd-main-header">
				<div class="row">
					<div class="col-sm-6">
						<h3>${user.userInfo.firstName += " " += user.userInfo.lastName}
							<span class="badge">${user.role.name}</span>
						</h3>
					</div>
					<sec:authorize access="hasAuthority('EDIT_USER')" var="editAllowedByRole"></sec:authorize>
					<sec:authentication property="name" var="principalName"></sec:authentication>
					<c:set var="editAllowedBySelfProfile" value="${user.username == principalName}"></c:set>
					<c:if test="${editAllowedByRole || editAllowedBySelfProfile}">
						<h3>
							<a href="${app}/admin/users/${user.username}" class="btn btn-primary pull-right">Edit</a>
						</h3>
					</c:if>
				</div>
			</header>
			<main>
				<div class="row">
					<section class="col-xs-6 col-sm-4">
						<img class="hd-user-image-large" src="${app}/${user.userInfo.imageUrl}" />
					</section>
					
					<div class="clearfix visible-xs-block"></div>
					
					<section class="col-sm-4">
						<header><h4>Information</h4></header>
						<p><strong>Username</strong>: ${user.username}</p>
						<p><strong>First name</strong>: ${user.userInfo.firstName}</p>
						<p><strong>Middle name</strong>: ${user.userInfo.middleName}</p>
						<p><strong>Last name</strong>: ${user.userInfo.lastName}</p>
						<p><strong>E-mail</strong>: ${user.userInfo.email}</p>
						<p><strong>Corporate phone</strong>: ${user.userInfo.corporatePhoneNumber}</p>
						<p><strong>Start of work</strong>: <fmt:formatDate value="${user.userInfo.startOfWork}" pattern="dd MMMM yyyy" /></p>
						<p><strong>Line manager</strong>:
							<c:if test="${user.lineManager != null}">
								<a href="${app}/users/${user.lineManager.username}">
									${user.lineManager.userInfo.firstName += " " += user.lineManager.userInfo.lastName}
								</a>
							</c:if>
						</p>
							
						<p><strong>Subordinates count</strong>: ${fn:length(user.subordinates)}</p>
					</section>
					
					<section class="col-sm-4">
						<header><h4>Personal Information</h4></header>
						<p><strong>Birthday</strong>: <fmt:formatDate value="${user.personalInfo.birthday}" pattern="dd MMMM yyyy" /></p>
						<p><strong>Personal phone</strong>: ${user.personalInfo.phoneNumber}</p>
						<p><strong>Skype</strong>: ${user.personalInfo.skypeName}</p>
					</section>
				</div>
			</main>
			
			<c:import url="/imports/mainFooter"></c:import>
		</div>

		<div class="hd-modals"></div>

		<c:import url="/imports/scripts"></c:import>
	</body>
</html>