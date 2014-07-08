# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/


$ ->
  $('.dummy-visualization').mouseover(mouseoverFn)
  $('.dummy-visualization').mouseout(mouseoutFn)

mouseoverFn = ->  
	# at this point, it's just show/hide, so I might as well use those functions instead
	
	$('.sidebar .info-box').css('background-color', 'rgba(231, 76, 60, 1)');
	console.log('mouseover');

mouseoutFn = ->
	$('.sidebar .info-box').css('background-color', 'rgba(231, 76, 60, 0)');
	console.log('mouseout');