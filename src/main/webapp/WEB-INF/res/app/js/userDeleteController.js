'use strict';

var SUBJECT = '';
var FORM = $('#hd-delete-form');

$('.js-hd-delete-user-btn').each(function(index, item) {
	$(item).click(function(event) {
		event.preventDefault();
		
		var deleteKey = $(item).data('key');
		SUBJECT = '<b>' + $(item).data('name') + '</b> user';
		
		$('#hd-delete-subject').html(SUBJECT);
		
		FORM.attr('action', APP_ROOT + '/admin/users/' + deleteKey);
		
		FORM.append('<input type="hidden" name="startOfWork" value="1900-01-01">');
		FORM.append('<input type="hidden" name="birthday" value="1900-01-01">');
		FORM.append('<input type="hidden" name="lineManager" value="">');
		FORM.append('<input type="hidden" name="personalPhone" value="">');
		FORM.append('<input type="hidden" name="skypeName" value="">');
		FORM.append('<input type="hidden" name="isDeleted" value="true">');
		
	});
});