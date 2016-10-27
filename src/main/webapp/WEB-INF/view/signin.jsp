<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="app" value="${pageContext.servletContext.contextPath}" />

<!DOCTYPE html>
<html lang="en">
	<head>
		<c:import url="/imports/head?pageTitle=Sign In"></c:import>
	</head>
	
	<body data-page="sign-in-page">
		<div class="container">
			<c:import url="/imports/mainNav?root=false"></c:import>
			
			<main>
				<form class="hd-auth-form" action="${app}/signin" method="post">
					<div class="form-group has-feedback">
						<label class="control-label sr-only" for="username">Username</label>
						<input type="text" class="form-control" id="username" name="username" placeholder="Username" autofocus="autofocus" required="required"/>
						<i class="glyphicon glyphicon-user form-control-feedback"></i>
					</div>
					
					<div class="form-group has-feedback">
						<label class="control-label sr-only" for="password">Password</label>
						<input type="password" class="form-control" id="password" name="password" placeholder="Password" required="required" />
						<i class="glyphicon glyphicon-lock form-control-feedback"></i>
					</div>
					
					<button type="submit" class="btn btn-primary btn-block">Sign In</button>
					
				</form>
			</main>
			
			<c:import url="/imports/mainFooter"></c:import>
		</div>

		<div class="hd-modals"></div>

		<c:import url="/imports/scripts"></c:import>

	</body>
</html>