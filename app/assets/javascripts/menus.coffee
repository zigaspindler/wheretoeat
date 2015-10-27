$ ->
  $('#add_menu_fields').click (e) ->
    e.preventDefault()
    $('.menus').append($('.menu_form_fields').first().clone())