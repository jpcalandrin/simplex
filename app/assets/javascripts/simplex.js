var cont = 2;
$('#add-var-dec').click(function() {
  cont++;
  element = "<div class='row x" + cont + "' data-v1='x" + cont + "'>\
              <div class='col-sm-3'>\
                <div class='form-group'>\
                    <label class='control-label'>x" + cont +"</label>\
                    <input name='x[]' type='text' class='form-control'>\
                  </div>\
                </div>\
                <div class='col-sm-2'>\
                  <button data-v1='x" + cont + "' class='btn btn-default mg'>Remover</button>\
                </div>\
              </div>\
            </div>";
  $('.var-dec').append(element);
});

$( ".var-dec" ).on( "click", ".mg", function() {
  x = $(this).attr("data-v1");
  $("."+x).remove();
});

$("#add-res").on( "click", function() {
  x = [];
  $( ".var-dec > .row" ).each(function( index ) {
    x.push($(this).attr("data-v1"));
  });
  debugger;
});




