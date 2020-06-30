function change_category(obj){
  if(obj.value==""){
    document.getElementById("cc").style.display="none";
  }else{
    var categories = document.getElementsByClassName("category_class_"+obj.value);
    objSelect = document.getElementById("category_2");
    objSelect.options.length = 0;
    var varItem = new Option('', '');
    objSelect.options.add(varItem);
    for(var i=0;i<categories.length;i++){
      var varItem = new Option(categories[i].value, categories[i].id.replace("categoryid_",""));
      objSelect.options.add(varItem);
    }
    document.getElementById("cc").style.display="inline-block";
  }
}

(function ($) {
 "use strict";
  $(".sub_categories").hide();
  $(".toggle-button").bind("click", function(){
    $(".sub_"+$(this).attr("data-id")).slideToggle();
  })


  if($(".datetimePicker").length>0){
      $(".datetimePicker").datetimepicker({
          lang:"ch",
          timepicker:true,
          allowBlank:true,
          format:'Y/m/d H:i',
          onGenerate:function(){
          }
      });
  }

	/*----------------------------
	 jQuery MeanMenu
	------------------------------ */
	jQuery('nav#dropdown').meanmenu();
	/*----------------------------
	 jQuery myTab
	------------------------------ */
	$('#myTab a').click(function (e) {
		  e.preventDefault()
		  $(this).tab('show')
		});
		$('#myTab3 a').click(function (e) {
		  e.preventDefault()
		  //$(this).tab('show')
		});
		$('#myTab4 a').click(function (e) {
		  e.preventDefault()
		  $(this).tab('show')
		});

	  $('#single-product-tab a').click(function (e) {
		  e.preventDefault()
		  $(this).tab('show')
		});

	$('[data-toggle="tooltip"]').tooltip();

	$('#sidebarCollapse').on('click', function () {
                     $('#sidebar').toggleClass('active');

                 });
		// Collapse ibox function
			$('#sidebar ul li').on('click', function () {
				var button = $(this).find('i.fa.indicator-mn');
				button.toggleClass('fa-plus').toggleClass('fa-minus');

			});
	/*-----------------------------
			Menu Stick
		---------------------------------*/
		$(".sicker-menu").sticky({topSpacing:0});

		$('#sidebarCollapse').on('click', function () {
			$("body").toggleClass("mini-navbar");
			SmoothlyMenu();
		});
		$(document).on('click', '.header-right-menu .dropdown-menu', function (e) {
			  e.stopPropagation();
			});


/*----------------------------
 wow js active
------------------------------ */
 new WOW().init();

/*----------------------------
 owl active
------------------------------ */
  $("#owl-demo").owlCarousel({
      autoPlay: false,
	  slideSpeed:2000,
	  pagination:false,
	  navigation:true,
      items : 4,
	  /* transitionStyle : "fade", */    /* [This code for animation ] */
	  navigationText:["<i class='fa fa-angle-left'></i>","<i class='fa fa-angle-right'></i>"],
      itemsDesktop : [1199,4],
	  itemsDesktopSmall : [980,3],
	  itemsTablet: [768,2],
	  itemsMobile : [479,1],
  });

/*----------------------------
 price-slider active
------------------------------ */
	  $( "#slider-range" ).slider({
	   range: true,
	   min: 40,
	   max: 600,
	   values: [ 60, 570 ],
	   slide: function( event, ui ) {
		$( "#amount" ).val( "£" + ui.values[ 0 ] + " - £" + ui.values[ 1 ] );
	   }
	  });
	  $( "#amount" ).val( "£" + $( "#slider-range" ).slider( "values", 0 ) +
	   " - £" + $( "#slider-range" ).slider( "values", 1 ) );

/*--------------------------
 scrollUp
---------------------------- */
	$.scrollUp({
        scrollText: '<i class="fa fa-angle-up"></i>',
        easingType: 'linear',
        scrollSpeed: 900,
        animation: 'fade'
    });

})(jQuery);
