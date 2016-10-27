<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="app" value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html lang="en">
	<head>
		<c:import url="/imports/head?pageTitle=Users"></c:import>
	</head>
	
	<body data-page="users">
		<div class="container">
			<c:import url="/imports/mainNav?root=false"></c:import>
			<header class="hd-main-header">
				<div class="row">
					<div class="col-sm-6">
						<h3>Users</h3>
					</div>
				</div>
			</header>
			<main>
				<div class="row">
					<button type="button" id="hd-add-new-user-button" data-toggle="modal" data-target="#hd-modal-new-user" class="btn btn-success pull-right">Add User</button>
				</div>
				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>ID</th>
								<th>Name</th>
								<th>Role</th>
								<th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${users}" var="user" >
								<tr>
									<td>
										${user.key}
									</td>
									<td>
										<a href="${app}/users/${user.username}">${user.userInfo.firstName += " " += user.userInfo.lastName}</a>
									</td>
									<td>
										<a href="${app}/admin/roles/${user.role.key}">${user.role.name}</a>
									</td>
									<td>
										<sec:authorize access="hasAuthority('EDIT_USER')">
											<a href="${app}/admin/users/${user.username}"><i class="fa fa-pencil"></i></a>
										</sec:authorize>
										<sec:authorize access="hasAuthority('DELETE_USER')">
											<sec:authentication property="name" var="principalName"></sec:authentication>
											<c:if test="${user.username != principalName}">
												<a href="#hd-delete-confirmation-modal" data-toggle="modal" class="js-hd-delete-user-btn" data-key="${user.username}" data-name="${user.username}"><i class="fa fa-remove"></i></a>
											</c:if>
										</sec:authorize>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</main>
			
			<c:import url="/imports/mainFooter"></c:import>
		</div>

		<div class="hd-modals">
			<c:import url="/imports/modals/deleteConfirmationModal"></c:import>
		</div>

		<c:import url="/imports/scripts"></c:import>
		<script src="${app}/res/app/js/userDeleteController.js"></script>
	</body>
</html>