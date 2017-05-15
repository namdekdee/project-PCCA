$(function () {
    $("[data-hide]").on("click", function () {
        $(this).closest("." + $(this).attr("data-hide")).hide();
    });
    
    $('.datepicker').datepicker({
		autoclose : true
	});
    
	

});