<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<c:set var="app" value="${pageContext.servletContext.contextPath}" />

<aside class="modal fade" id="hd-modal-new-role">
	<div class="modal-dialog">
		<div class="modal-content">
			<header class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
				<h4 class="modal-title">New Role</h4>
			</header>
			<div class="modal-body">
				<form id="hd-new-role-form" method="post" action="${app}/admin/roles">
					<div class="form-group">
						<label for="name" class="control-label">Name</label>
						<input type="text" name="name" id="name" class="form-control" required="required" autofocus="autofocus">
					</div>
					<div class="form-group">
						<label for="description" class="control-label">Description</label>
						<textarea rows="5" class="form-control" name="description" id="description"></textarea>
					</div>
				</form>
			</div>
			<footer class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button form="hd-new-role-form" type="submit" class="btn btn-primary" id="hd-save-new-role-button">Add</button>
			</footer>
		</div>
	</div>
</aside>