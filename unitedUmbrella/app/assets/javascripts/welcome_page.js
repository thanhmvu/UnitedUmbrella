/*
	Spectral by HTML5 UP
	html5up.net | @n33co
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
*/

(function($) {

	skel
		.breakpoints({
			xlarge:	'(max-width: 1680px)',
			large:	'(max-width: 1280px)',
			medium:	'(max-width: 980px)',
			small:	'(max-width: 736px)',
			xsmall:	'(max-width: 480px)'
		});

	$(function() {

		var	$window = $(window),
			$body = $('body'),
			$wrapper = $('#page-wrapper'),
			$banner = $('#banner'),
			$header = $('#header');

		// Disable animations/transitions until the page has loaded.
			$body.addClass('is-loading');

			$window.on('load', function() {
				window.setTimeout(function() {
					$body.removeClass('is-loading');
				}, 100);
			});

		// Mobile?
			if (skel.vars.mobile)
				$body.addClass('is-mobile');
			else
				skel
					.on('-medium !medium', function() {
						$body.removeClass('is-mobile');
					})
					.on('+medium', function() {
						$body.addClass('is-mobile');
					});

		// Fix: Placeholder polyfill.
			$('form').placeholder();

		// Prioritize "important" elements on medium.
			skel.on('+medium -medium', function() {
				$.prioritize(
					'.important\\28 medium\\29',
					skel.breakpoint('medium').active
				);
			});

		// Scrolly.
			$('.scrolly')
				.scrolly({
					speed: 1500,
					offset: $header.outerHeight()
				});

		// Menu.
			$('#menu')
				.append('<a href="#menu" class="close"></a>')
				.appendTo($body)
				.panel({
					delay: 500,
					hideOnClick: true,
					hideOnSwipe: true,
					resetScroll: true,
					resetForms: true,
					side: 'right',
					target: $body,
					visibleClass: 'is-menu-visible'
				});

		// Header.
			if (skel.vars.IEVersion < 9)
				$header.removeClass('alt');

			if ($banner.length > 0
			&&	$header.hasClass('alt')) {

				$window.on('resize', function() { $window.trigger('scroll'); });

				$banner.scrollex({
					bottom:		$header.outerHeight() + 1,
					terminate:	function() { $header.removeClass('alt'); },
					enter:		function() { $header.addClass('alt'); },
					leave:		function() { $header.removeClass('alt'); }
				});

			}

	});

})(jQuery);


$(document).ready( function() {
	ready();
});

$(document).on('turbolinks:load', function() {
	ready();
});

var ready = function() {
	$('#select-lea').val('');
	$('#select-id').val('');
	$('#select-pid').val('');

	// trigger all form submissions
	$('.button').on('click', function() {
		var form = $(this).parents('form:first');
		form.submit();
	});

	// select LEA form
	$('#school-dropdown').on('change', function() {
		var value = $(this).val();
		if ( value == "" ) return;
		$('#input_lea').val(value);
		$(this).parents('form:first').submit();
	});

	$('#submit_multiple_lea').attr('disabled', true);
	$('#submit_multiple_id').attr('disabled', true);
	$('#submit_multiple_pid').attr('disabled', true);

	// add the corresponding number of input fields
	// enable submit button
	$('#select-lea').on('change', function () {
		$('#multiple_lea_inputs').empty();
		if ( $(this).val() == "" ) {
			$('#submit_multiple_lea').attr('disabled', true);
			return;
		}
		var numberOfBoxes = $(this).val();
		$('#submit_multiple_lea').attr('disabled', false);	
		for ( var i = 1 ; i <= numberOfBoxes ; i++ ) {
			createInputBox( "#multiple_lea_inputs", i, numberOfBoxes, "ID" );
		}
	});

	$('#select-id').on('change', function () {
		$('#multiple_id_inputs').empty();
		if ( $(this).val() == "" ) {
			$('#submit_multiple_id').attr('disabled', true);
			return;
		}
		var numberOfBoxes = $(this).val();
		$('#submit_multiple_id').attr('disabled', false);	
		for ( var i = 1 ; i <= numberOfBoxes ; i++ ) {
			createInputBox( "#multiple_id_inputs", i, numberOfBoxes, "ID" );
		}
	});

	$('#select-pid').on('change', function () {
		$('#multiple_pid_inputs').empty();
		if ( $(this).val() == "" ) {
			$('#submit_multiple_pid').attr('disabled', true);
			return;
		}
		var numberOfBoxes = $(this).val();
		$('#submit_multiple_pid').attr('disabled', false);	
		for ( var i = 1 ; i <= numberOfBoxes ; i++ ) {
			createInputBox( "#multiple_pid_inputs", i, numberOfBoxes, "ID" );
		}
	});
}

function createInputBox( div_id, id, numberOfBoxes, typeOfInput ) {
	var inputBox;
	var placeHolderName = typeOfInput.toLowerCase();
	if ( numberOfBoxes % 2 == 0 ) {
		inputBox = $(" \
			<div class='6u 12u$(xsmall)'> \
				<input type='text' name='" + placeHolderName + id + "' value='' placeholder='" + typeOfInput + " of school " + id + "' /> \
			</div>'").appendTo(div_id);
	}
	else {
		inputBox = $(" \
			<div class='4u 12u$(xsmall)'> \
				<input type='text' name='" + placeHolderName + id + "' value='' placeholder='" + typeOfInput + " of school " + id + "' /> \
			</div>'").appendTo(div_id);
	}
}

