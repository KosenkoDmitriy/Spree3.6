(function($){
  $(document).ready(function(){
		//Category show/hide children categories
		$('#product_nav li a.sub-menu').click(function() {
			var parent = $(this).parents('li:eq(0)');
			$(' > ul', parent).toggle();
			$(this).toggleClass('current');
			return false;
		});

    //Contact form
		$('form.contact_form').validate({
			errorElement: "span",
			errorClass: "error"
		});
  });
})(jQuery);
