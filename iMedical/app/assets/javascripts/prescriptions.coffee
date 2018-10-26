# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
	$('#prescription_drugName').keydown ->
		console.log "test"
		if $(this).val().length > 3
			$.ajax "/searchDrug", 
				type: "GET"
				dataType: "json"
				data: {name: $(this).val()}
				success: (data, textStatus, xhr) -> 
					indice = 0;
					$('#farmaci').empty()
					while indice < data.length
						$('#farmaci').append("<div> <input type='radio' name='farmaco' value = '"+data[indice]+"'> "+data[indice]+"</div>")
						indice = indice + 1
					#console.log("ehehe")
					$('#farmaci input').each ->
						$(this).click ->
							console.log $(this).val()
							$('#prescription_drugName').val($(this).val())
