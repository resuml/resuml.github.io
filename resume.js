$(document).ready(function(){
  $('.tenure').each(function(index, value) {
    let start = undefined;
    let end = undefined;

    let dates = $(this).find('.date');
    if(dates.length == 1){
      start = $(dates[0]).html();
    }
    else if(dates.length == 2){
      start = $(dates[0]).html();

      if($(dates[1]).html() != 'Current'){
        end = $(dates[1]).html();
      }
    }

    if((start && start.length == 4) || (end && end.length == 4)){
      start = moment(start, 'YYYY').startOf('year');
      end = moment(end, 'YYYY').startOf('year');
    }
    else{
      start = moment(start).startOf('month');
      end = moment(end).endOf('month');
    }

    let diff = end.diff(start);
    let duration = moment.duration(diff)
    duration = duration.add(15, 'day'); //put the duration in the middle of a month to achieve proper rounding

    let s = (duration.years() > 0 ? duration.years() + ' year' + (duration.years() == 1 ? '' : 's') : '');
    s = s + (duration.months() > 0 ? ', ' + duration.months() + ' month' + (duration.months() == 1 ? '' : 's') : '');
    s = s.replace(/^, /g, '');

    $(this).find('.duration').html(s);
  });

  $('.date').html(function(index, value) {
    let input = (value.length == 4 ? 'YYYY' : null);
    let output = (value.length == 4 ? 'YYYY' : 'MMM YYYY');

    return (value == 'Current' ? value : moment(value, input).format(output));
  });
});