$(document).ready(function(){
  $(document).ready(function(){
    $('.modal').modal();
  });

  calculateTenures();
  beautifyDates();
  setupPrintSections();
});

function calculateTenures(){
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
}

function beautifyDates(){
  $('.date').html(function(index, value) {
    let input = (value.length == 4 ? 'YYYY' : null);
    let output = (value.length == 4 ? 'YYYY' : 'MMM YYYY');

    return (value == 'Current' ? value : moment(value, input).format(output));
  });
}

function setupPrintSections(){
  let sections = $('#print-sections');
  $(sections).empty();

  let col = null;
  $('.section').each(function(i, e){
    if(i % 3 == 0){
      col = $('<div/>').addClass('col s4');
      $(sections).append(col);
    }

    let checkbox = $('<input/>').attr('type', 'checkbox').val($(e).attr('id'));
    if(!$(e).hasClass('no-print')){
      $(checkbox).prop('checked', 'checked');
    }

    $(col).append(
      $('<label/>')
        .append(checkbox)
        .append($('<span/>').html($(e).find('.header').html()))
    );
  });

  $(sections).find('label').wrap('<p/>');
}

function printSections(){
  $('#modalPrint').modal('close');

  $('.section').addClass('no-print');
  $('#print-sections input').each(function(){
    if($(this).is(':checked')){
      $('#' + $(this).val()).removeClass('no-print');
    }
  }).promise().done(function(){window.print();});
}