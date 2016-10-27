<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="app" value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html lang="en">
	<head>
		<c:import url="/imports/head?pageTitle=${role.name}"></c:import>
	</head>
	
	<body data-page="role" data-target="${role.key}">
		<div class="container">
			<c:import url="/imports/mainNav?root=false"></c:import>
			<header class="hd-main-header">
				<div class="row">
					<div class="col-sm-6">
						<h3>${role.name}</h3>
						${role.description}
					</div>
				</div>
			</header>
			<main>
				<ul class="nav nav-tabs" role="tablist">
					<li class="active"><a href="#authorities-tab" role="tab" data-toggle="tab">Authorities</a></li>
					<li><a href="#users-tab" role="tab" data-toggle="tab">Users</a></li>
				</ul>
				
				<div class="tab-content">
					<div class="active tab-pane fade in" id="authorities-tab">
						<form action="${app}/admin/roles/${role.key}" method="post">
							<input type="hidden" name="name" id="name" value="${role.name}">
							<input type="hidden" name="description" id="description" value="${role.description}">
							<h2>
								Authorities
								<div class="btn-group pull-right">
									<button type="submit" class="btn btn-success">Save</button>
								</div>
							</h2>
							
							<div class="row" id="hd-role-authorities">
								<c:forEach items="${authorityMatrix}" var="authority">
									<div class="col-xs-12 col-sm-4 col-md-3">
										<c:set value="${fn:contains(role.authorities, authority) }" var="checked"></c:set>
										<div class="checkbox">
											<label>
												<input type="checkbox" name="authorities" id="authorities" value="${authority}" ${checked? "checked":""}>
												${authority}
											</label>
										</div>
									</div>
								</c:forEach>
							</div>
						</form>
					</div>
					
					<div class="tab-pane fade" id="users-tab">
						<h2>Users</h2>
						<div class="table-responsive">
							<table class="table table-hover">
								<thead>
									<tr>
										<th>ID</th>
										<th>Name</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${role.users}" var="user">
										<tr>
											<td>${user.key}</td>
											<td>
												<a href="${app}/users/${user.username}">${user.userInfo.firstName += " " += user.userInfo.lastName}</a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			
			</main>
			
			<c:import url="/imports/mainFooter"></c:import>
		</div>

		<div class="hd-modals">
		</div>

		<c:import url="/imports/scripts"></c:import>
	</body>
</html>