// jQuery for page scrolling feature - requires jQuery Easing plugin
$(function() {
    $('.page-scroll a').bind('click', function(event) {
        var href = this.getAttribute('href');
        if (!href || !href.startsWith('#') ||
            window.matchMedia('(prefers-reduced-motion: reduce)').matches) {
            return;
        }

        var target = document.getElementById(href.slice(1));
        if (!target) {
            return;
        }

        $('html, body').stop().animate({
            scrollTop: $(target).offset().top
        }, 1500, 'easeInOutExpo');
        event.preventDefault();
    });
});

// Highlight the top nav as scrolling occurs
$('body').scrollspy({
    target: '.navbar-fixed-top'
})

// Closes the Responsive Menu on Menu Item Click
$('.navbar-collapse ul li a').click(function() {
    $('.navbar-toggle:visible').click();
});
