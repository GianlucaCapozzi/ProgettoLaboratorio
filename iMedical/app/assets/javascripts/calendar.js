//= require moment
//= require fullcalendar

// Optional locale  change '// require' --> '//= require' to enable
// require fullcalendar/locale-all
// or sepecific locale
// require fullcalendar/locale/ms

// Optional addons  change '// require' --> '//= require' to enable
//=require fullcalendar/scheduler
//=require fullcalendar/gcal

var initialize_calendar;

initialize_calendar = function() {
    $('.calendar').each(function(){
        var calendar = $(this);
        calendar.fullCalendar({
            schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
            header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
            selectable: true,
            selectHelper: true,
            editable: true,
            weekends: false,
            eventLimit: true,
            events: '/examinations.json',

            select: function(start, end) {
                $.getScript('/patients/'+uid+'/examinations', function() {});

                calendar.fullCalendar('unselect');
            },

            eventDrop: function(event, delta, revertFunc) {
                event_data = {
                    event: {
                        id: event.id,
                        start: event.start.format(),
                        end: event.end.format()
                    }
                };
                $.ajax({
                    url: event.update_url,
                    data: event_data,
                    type: 'PATCH'
                });
            },

            eventClick: function(event, jsEvent, view) {
                $.getScript(event.edit_url, function() {});
            }
        });
    });
};
$(document).on('turbolinks:load', initialize_calendar);
