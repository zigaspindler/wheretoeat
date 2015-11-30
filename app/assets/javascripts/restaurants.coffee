$ ->
  @refreshInProgress = false

  $('.refresh_menus').click (e) ->
    e.preventDefault()

    return if @refreshInProgress

    $('.alert').alert('close')
    @refreshInProgress = true
    $(this).children('i').addClass('fa-spin')

    $.get $(this).attr('href')
      .done ->
        $('#alerts').append '<div class="alert alert-success"><button type="button" class="close" data-dismiss="alert">&times;</button>Menus refreshed</div>'
      .fail ->
        $('#alerts').append '<div class="alert alert-danger"><button type="button" class="close" data-dismiss="alert">&times;</button>Something went wrong</div>'
      .always =>
        $(@).children('i').removeClass('fa-spin')
        @refreshInProgress = false
