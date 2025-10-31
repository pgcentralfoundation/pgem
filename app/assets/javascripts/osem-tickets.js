function update_price($this){
    var ticket_id = $this.data('id');
    // Calculate price for row
    var value = $this.val();
    var price = $('#price_' + ticket_id).data().price;
    var row_total = accounting.formatMoney(value * price, parent.currency_symbol, 0, parent.currency_delimiter, parent.currency_separator);
    $('#total_row_' + ticket_id).text(row_total);

    // Calculate total price
    var total = 0;
    $('.total_row').each(function( index ) {
        var row_val = accounting.unformat($(this).text());
        total += parseFloat(row_val);
    });
    total = accounting.formatMoney(total, parent.currency_symbol, 0, parent.currency_delimiter, parent.currency_separator);
    $('#total_price').text(total);
}

function save_state() {
    form_inputs = $('select')
    var input_states = []
    $.each(form_inputs, function(i, v){
        input_states.push([v.id, v.value]);
    });
    sessionStorage.setItem('input_states', JSON.stringify(input_states));
}

function restore_state () {
    var input_states = sessionStorage.getItem('input_states')
    if (input_states) {
        var parsed = JSON.parse(input_states)
        parsed.forEach(function(element) {
            $('#'+element[0]).val(element[1])
        });
        parsed.forEach(function(element) {
            $('#'+element).trigger('change');
        });
        sessionStorage.removeItem('input_states')
    }
}

function check_qty () {
    let total_qty = undefined
    $('select.quantity').map(function() {
        total_qty += parseInt(this.value);
    });
    $('#submit-checkout-btn').prop('disabled', total_qty === 0)
}

$( document ).ready(function() {
    if (typeof(tix) !== 'undefined' && tix) {
      document.getElementById('tickets__' + tix).value = '1';
    }

    $('select.quantity').each(function() {
        update_price($(this));
    });

    $('select.quantity').change(function() {
        update_price($(this));
        check_qty();
    });
    $(function () {
      $('[data-toggle="tooltip"]').tooltip();
    });

    $('#apply_code').on('click', save_state)
    restore_state();
    check_qty();
});
