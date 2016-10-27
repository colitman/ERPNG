<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="app" value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html lang="en">
	<head>
		<c:import url="/imports/head?pageTitle=Roles"></c:import>
	</head>
	
	<body data-page="roles">
		<div class="container">
			<c:import url="/imports/mainNav?root=false"></c:import>
			<header class="hd-main-header">
				<div class="row">
					<div class="col-sm-6">
						<h3>Roles</h3>
					</div>
				</div>
			</header>
			<main>
				<div class="row">
					<button type="button" id="hd-add-new-role-button" data-toggle="modal" data-target="#hd-modal-new-role" class="btn btn-success pull-right">Add role</button>
				</div>
				<div class="table-responsive">
					<table class="table table-hover">
						<thead>
							<tr>
								<th>Name</th>
								<th>Description</th>
								<th>Users Count</th>
								<th>Authorities Count</th>
								<th>Actions</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${roles}" var="role" >
								<tr>
									<td>
										<a href="${app}/admin/roles/${role.key}">${role.name}</a>
									</td>
									<td>${role.description}</td>
									<td>${fn:length(role.users)}</td>
									<td>
										<c:if test="${empty fn:join(fn:split(role.authorities, ','),'')}" var="noAuthorities">0</c:if>
										<c:if test="${not noAuthorities}"> ${fn:length(fn:split(role.authorities, ","))}</c:if>
									</td>
									<td>
										<c:if test="${empty role.users}">
											<sec:authorize access="hasAuthority('DELETE_ROLE')">
												<a href="#hd-delete-confirmation-modal" data-toggle="modal" class="js-hd-delete-role-btn" data-key="${role.key}" data-name="${role.name}"><i class="fa fa-remove"></i></a>
											</sec:authorize>
										</c:if>
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
			<c:import url="/imports/modals/newRoleModal"></c:import>
			<c:import url="/imports/modals/deleteConfirmationModal"></c:import>
		</div>

		<c:import url="/imports/scripts"></c:import>
		<script src="${app}/res/app/js/roleDeleteController.js"></script>
	</body>
</html>