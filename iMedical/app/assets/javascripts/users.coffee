# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'turbolinks:load', ->
	console.log "caricato"
	$('#dataAttuale').change ->
		url = window.location.href.split("?")[0]
		url = url + "?date=" + $('#dataAttuale').val()
		window.location.href = url
