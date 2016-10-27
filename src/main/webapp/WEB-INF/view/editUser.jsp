<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="app" value="${pageContext.servletContext.contextPath}" />
<sec:authorize access="hasAuthority('EDIT_USER')" var="editAllowedByRole"></sec:authorize>

<!DOCTYPE html>
<html lang="en">
	<head>
		<c:import url="/imports/head?pageTitle=${user.username} :: Edit"></c:import>
	</head>
	
	<body data-page="editUser" data-target="${username}">
		<div class="container">
			<c:import url="/imports/mainNav?root=false"></c:import>
			<header class="hd-main-header">
				<div class="row">
					<div class="col-sm-6">
						<h3>${user.userInfo.firstName += " " += user.userInfo.lastName}</h3>
					</div>
				</div>
			</header>
			<main>
				<div class="row">
					<form action="${app}/admin/users/${user.username}" method="post" id="hd-user-edit-form">
						<section class="col-sm-6">
							<header><h4>Information</h4></header>
							<p><strong>Username</strong>: ${user.username}</p>
							<p><strong>First name</strong>: ${user.userInfo.firstName}</p>
							<p><strong>Middle name</strong>: ${user.userInfo.middleName}</p>
							<p><strong>Last name</strong>: ${user.userInfo.lastName}</p>
							<p><strong>E-mail</strong>: ${user.userInfo.email}</p>
							<p><strong>Corporate phone</strong>: ${user.userInfo.corporatePhoneNumber}</p>
							<p><strong>Subordinates count</strong>: ${fn:length(user.subordinates)}</p>
							
							<c:if test="${!editAllowedByRole}">
								<p><strong>Start of Work</strong>:  <fmt:formatDate value="${user.userInfo.startOfWork}" pattern="dd MMMM yyyy" /></p>
								<p><strong>Line manager</strong>:
									<c:if test="${user.lineManager != null}">
										<a href="${app}/users/${user.lineManager.username}">
												${user.lineManager.userInfo.firstName += " " += user.lineManager.userInfo.lastName}
										</a>
									</c:if>
								</p>
							</c:if>
							
							<c:if test="${editAllowedByRole}">
								
								<hr>
								
								<div class="form-group">
									<label for="startOfWork">Start of Work</label>
									<fmt:formatDate value="${user.userInfo.startOfWork}" pattern="yyyy-MM-dd" var="startOfWorkString"></fmt:formatDate>
									<input type="date" class="form-control" name="startOfWork" id="startOfWork" value="${startOfWorkString}">
								</div>
								
								<div class="form-group">
									<label for="lineManager">Line Manager</label>
									<select class="form-control" name="lineManager" id="lineManager">
										<option value="hd_no_manager" ${user.lineManager == null? "selected":""}>No manager</option>
										<c:forEach items="${managers}" var="manager">
											<c:if test="${user.username != manager.username}">
												<c:set var="currentManager" value="${user.lineManager != null && user.lineManager.username == manager.username}"></c:set>
												<option value="${manager.username}" ${currentManager? "selected":""}>${manager.userInfo.firstName += " " += manager.userInfo.lastName}</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
								
								<div class="form-group">
									<label for="role">User Role</label>
									<select class="form-control" name="role" id="role">
										<option value="-1" ${user.role == null? "selected":""}>No role</option>
										<c:forEach items="${roles}" var="role">
											<c:if test="${user.role.name != role.name}">
												<c:set var="currentRole" value="${user.role != null && user.role.name == role.name}"></c:set>
												<option value="${role.key}" ${currentRole? "selected":""}>${role.name}</option>
											</c:if>
										</c:forEach>
									</select>
								</div>
							</c:if>
						</section>
						
						<section class="col-sm-6">
							<header><h4>Personal Information</h4></header>
							<div class="form-group">
								<label for="birthday">Birthday</label>
								<fmt:formatDate value="${user.personalInfo.birthday}" pattern="yyyy-MM-dd" var="birthdayString"></fmt:formatDate>
								<input type="date" class="form-control" name="birthday" id="birthday" value="${birthdayString}">
							</div>
							
							<div class="form-group">
								<label for="personalPhone">Personal Phone</label>
								<input type="text" class="form-control" name="personalPhone" id="personalPhone" value="${user.personalInfo.phoneNumber}">
							</div>
							
							<div class="form-group">
								<label for="skypeName">Skype</label>
								<input type="text" class="form-control" name="skypeName" id="skypeName" value="${user.personalInfo.skypeName}">
							</div>
						</section>
					</form>
				</div>
				<hr>
				<button type="submit" form="hd-user-edit-form" class="btn btn-success">Save</button>
			</main>
			
			<c:import url="/imports/mainFooter"></c:import>
		</div>

		<div class="hd-modals"></div>

		<c:import url="/imports/scripts"></c:import>
	</body>
</html>