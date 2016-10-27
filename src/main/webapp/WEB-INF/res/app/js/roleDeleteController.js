'use strict';

var SUBJECT = '';
var FORM = $('#hd-delete-form');

$('.js-hd-delete-role-btn').each(function(index, item) {
	$(item).click(function(event) {
		event.preventDefault();
		
		var deleteKey = $(item).data('key');
		SUBJECT = '<b>' + $(item).data('name') + '</b> user role';
		
		$('#hd-delete-subject').html(SUBJECT);
		
		FORM.attr('action', APP_ROOT + '/admin/roles/' + deleteKey);
		FORM.append('<input type="hidden" name="name" value="">');
		FORM.append('<input type="hidden" name="description" value="">');
		FORM.append('<input type="hidden" name="authorities" value="">');
		FORM.append('<input type="hidden" name="isDeleted" value="true">');
		
	});
});