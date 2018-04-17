$(document).mouseup(function (e)
{
    var container = $(".not-listing");
    var container1 = $(".dropdown-menu1");
    var container2 = $(".user-comm-sec");
    var container3 = $(".comment-comm-sec");
        if (!container.is(e.target) // if the target of the click isn't the container...
                && container.has(e.target).length === 0) // ... nor a descendant of the container
        {
            container.slideUp();
        }
         if (!container1.is(e.target) // if the target of the click isn't the container...
                && container1.has(e.target).length === 0) // ... nor a descendant of the container
         {
            container1.slideUp();
        }
        if (!container.is(e.target) // if the target of the click isn't the container...
                && container.has(e.target).length === 0) // ... nor a descendant of the container
        {
            container2.slideUp();
        }
         if (!container1.is(e.target) // if the target of the click isn't the container...
                && container1.has(e.target).length === 0) // ... nor a descendant of the container
         {
            container3.slideUp();
        }
		
		

    });


$(".sign1").click(function(){
    $("body").toggleClass("sign-up")
});

$(".user-click").click(function(){

    $(".user-comm-sec").slideToggle();
});

$(".comment-click").click(function(){

    $(".comment-comm-sec").slideToggle();
});

$('.icon-left-bar > a').click(function(){

    $('body').toggleClass('left-menu');
});
$(".btn-slideright").click(function(){
		$("body").toggleClass("slide-left-panel-desk")
		});
/*$('#banner-slider').owlCarousel({
    loop:true,
    margin:0,
    nav:false,
    animateIn:'fadeIn',
    animateOut:'fadeOut',
    autoplay:false,
    navigationText:[
    "<i class='fa fa-angle-left'></i>",
    "<i class='fa fa-angle-right'></i>"
    ],
    autoplayTimeout:3000,
    mouseDrag:false,
    dots:false,
    navText:false,
    smartSpeed:1000,
    responsive:{
        0:{
            items:1
        }
    }
});*/

$(document).ready(function(){
    $(".open-list-family").click(function() {
        if ($(".family-list").is(":visible") == true) {
            $(".family-list").slideUp("family-list")
        }
        else {
            $(".family-list").slideDown("family-list")
        }
    });
    $(".prof-img").click(function(){
        if ($(".dropdown-menu1").is(":visible")==true){
        $(".dropdown-menu1").slideUp("dropdown-menu1")
        }
        else{
            $(".dropdown-menu1").slideDown("dropdown-menu1")
        }
    });
});

/** Sticky footer js***/
$(window).bind("load", function () {
    var footer = $("#footer");

    var pos = footer.position();

    var height = $(window).height();
    height = height - pos.top;
    height = height - footer.height();
    if (height > 0) {
        footer.css({
            'margin-top': height + 'px'
        });
    }
});





/*sticky header*/
$(window).scroll(function(){
  var sticky = $('body'),
  scroll = $(window).scrollTop();
//sticky header
if (scroll >= 100) sticky.addClass('sticky-header');
else sticky.removeClass('sticky-header');
  //hide show rigth, left social media buttons, scroll top button
  var scroll_header=$('header').offset().top;
  var header_height=  $('header').height();
  var final_height = scroll_header + header_height;
  if ($(this).scrollTop() >= final_height) {
    $('.social-media-left,#toTop1').fadeIn(1000);
} else {
    $('.social-media-left,#toTop1').fadeOut(1000);
}
});

/*$(function () {
  $('[data-toggle="tooltip"]').tooltip()
});*/

//function fullSize() {
//    var heights = window.innerHeight;
//    jQuery(".dashboard-middle-sec,.inner-pages").css('min-height', (heights + 0) + "px");
//}
//fullSize()
