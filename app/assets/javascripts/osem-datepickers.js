// get current_date
var today = new Date().toISOString().slice(0, 10);
$(function() {
	$("input[id^='datetimepicker']").datetimepicker({
		ignoreReadonly: true,
		useCurrent: false,
		sideBySide: true,
		format: 'YYYY-MM-DD HH:mm'
	});

	$("#registration-arrival-datepicker").datetimepicker({
		useCurrent: false,
		ignoreReadonly: true,
		minuteStepping: 15,
		sideBySide: true,
		format: "YYYY-MM-DD HH:mm",
		// current_date <= arrival_date <= end_date
		maxDate: $("#registration-arrival-datepicker").attr('end_date'),
		minDate: today,
		defaultDate: $("#registration-arrival-datepicker").attr('start_date'),
	});

	$("#registration-departure-datepicker").datetimepicker({
		useCurrent: false,
		ignoreReadonly: true,
		minuteStepping: 15,
		sideBySide: true,
		format: "YYYY-MM-DD HH:mm",
		// departure_date > start_date
		minDate: $("#registration-arrival-datepicker").attr('start_date'),
		defaultDate: $("#registration-arrival-datepicker").attr('end_date'),
	});

	$("#registration-arrival-datepicker").on("dp.change", function(e) {
		// departure_date > start_date,arrival_date
		if ((new Date(e.date).getTime()) > (new Date($("#registration-arrival-datepicker").attr('start_date')).getTime())) {
			$('#registration-departure-datepicker').data("DateTimePicker").setMinDate(e.date);
		} else {
			$('#registration-departure-datepicker').data("DateTimePicker").setMinDate($("#registration-arrival-datepicker").attr('start_date'));
		}
	});

	// departure_date >= arrival_date
	$("#registration-departure-datepicker").on("dp.change", function(e) {
		$('#registration-arrival-datepicker').data("DateTimePicker").setMaxDate(e.date);
	});

	$("#benefit-duedate-datepicker").datetimepicker({
		ignoreReadonly: true,
		useCurrent: false,
		format: "YYYY-MM-DD",
	});

	$("#conference-start-datepicker").datetimepicker({
		useCurrent: false,
		ignoreReadonly: true,
		format: "YYYY-MM-DD",
		// conference-start-day >= Current_date
		minDate: $("#conference-start-datepicker").val() ? $("#conference-start-datepicker").val() : today,
	});


	$("#conference-end-datepicker").datetimepicker({
		ignoreReadonly: true,
		useCurrent: false,
		format: "YYYY-MM-DD",
	});

	$("#campaign-start-datepicker").datetimepicker({
		ignoreReadonly: true,
		useCurrent: false,
		format: "YYYY-MM-DD",
	});

	//   end_date_conference >= registration-period-Start_date >= Current_date
	//   registration-period-Start_date <= registration-period-End_date <= End_date (of conference)
	$("#registration-period-start-datepicker").datetimepicker({
		ignoreReadonly: true,
		useCurrent: false,
		format: "YYYY-MM-DD",
		minDate: $("#registration-period-start-datepicker").val() ? $("#registration-period-start-datepicker").val() : today,
		maxDate: $("#registration-period-start-datepicker").attr('end_date'),
	});

	$("#registration-period-end-datepicker").datetimepicker({
		ignoreReadonly: true,
		useCurrent: false,
		format: "YYYY-MM-DD",
		minDate: $("#registration-period-end-datepicker").val() ? $("#registration-period-end-datepicker").val() : today,
		maxDate: $("#registration-period-start-datepicker").attr('end_date'),
	});

	$("#speaker-registration-deadline-datepicker").datetimepicker({
		ignoreReadonly: true,
		useCurrent: false,
		format: "YYYY-MM-DD",
		minDate: $("#speaker-registration-deadline-datepicker").val() ? $("#speaker-registration-deadline-datepicker").val() : today,
		maxDate: $("#registration-period-start-datepicker").attr('end_date'),
		showClear: true
	});

	$("#cfp-notification-deadline-datepicker").datetimepicker({
		ignoreReadonly: true,
		useCurrent: false,
		format: "YYYY-MM-DD",
		minDate: today,
		maxDate: $("#cfp-notification-deadline-datepicker").attr('end_date'),
		showClear: true
	});

	$("#registration-period-early-bird-datepicker").datetimepicker({
		ignoreReadonly: true,
		useCurrent: false,
		format: "YYYY-MM-DD",
		minDate: $("#registration-period-early-bird-datepicker").val() ? $("#registration-period-early-bird-datepicker").val() : today,
		maxDate: $("#registration-period-start-datepicker").attr('end_date'),
	});

	$("#conference-start-datepicker").on("dp.change", function(e) {
		$('#conference-end-datepicker').data("DateTimePicker").minDate(e.date);
	});
	$("#conference-end-datepicker").on("dp.change", function(e) {
		$('#conference-start-datepicker').data("DateTimePicker").maxDate(e.date);
	});

	$("#registration-period-start-datepicker").on("dp.change", function(e) {
		$('#registration-period-end-datepicker').data("DateTimePicker").minDate(e.date);
	});
	$("#registration-period-end-datepicker").on("dp.change", function(e) {
		$('#registration-period-start-datepicker').data("DateTimePicker").maxDate(e.date);
	});

	$(".target-due-date-datepicker").datetimepicker({
		format: "YYYY-MM-DD"
	});


	$(".ticket-start-date-datepicker").datetimepicker({
		format: "YYYY-MM-DD"
	});

	$(".ticket-end-date-datepicker").datetimepicker({
		format: "YYYY-MM-DD"
	});

	$(".ticket-start-date-datepicker").on("dp.change", function(e) {
		$('.ticket-end-date-datepicker').data("DateTimePicker").minDate(e.date);
	});
	$(".ticket-end-date-datepicker").on("dp.change", function(e) {
		$('.ticket-start-date-datepicker').data("DateTimePicker").maxDate(e.date);
	});

	//   FIXME: add start-before-end validations
	$(".room-start-date-datepicker").datetimepicker({
		format: "YYYY-MM-DD"
	});

	$(".room-end-date-datepicker").datetimepicker({
		format: "YYYY-MM-DD"
	});
	$(".room-start-date-datepicker").on("dp.change", function(e) {
		$('.room-end-date-datepicker').data("DateTimePicker").minDate(e.date);
	});
	$(".room-end-date-datepicker").on("dp.change", function(e) {
		$('.room-start-date-datepicker').data("DateTimePicker").maxDate(e.date);
	});

	$("#report-start-datepicker").datetimepicker({
		ignoreReadonly: true,
		useCurrent: false,
		format: "YYYY-MM-DD",
		maxDate: today,
	});

	$("#report-end-datepicker").datetimepicker({
		ignoreReadonly: true,
		useCurrent: false,
		format: "YYYY-MM-DD",
		maxDate: today,
	});

	/* Appends the datetimepicker to new injected nested target fields. */
	$('a:contains("Add target")').click(function() {
		setTimeout(function() {
				$('.target-due-date-datepicker').not('.hasDatepicker').datetimepicker({
					//   pickTime: false,
					format: "YYYY-MM-DD"
				});
			},
			5)
	});
});