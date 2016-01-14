$ ->
  refreshInProgress = false

  menus = $ '.refresh_menus'

  menus.click (e) ->
    e.preventDefault()

    return if refreshInProgress

    $el = $ @
    $('.alert').alert('close')

    refreshInProgress = true
    $el.children('i').addClass('fa-spin')

    $.get $el.attr('href')
      .done ->
        $('#alerts').append '<div class="alert alert-success"><button type="button" class="close" data-dismiss="alert">&times;</button>Menus refreshed</div>'
      .fail ->
        $('#alerts').append '<div class="alert alert-danger"><button type="button" class="close" data-dismiss="alert">&times;</button>Something went wrong</div>'
      .always ->
        $el.children('i').removeClass('fa-spin')
        refreshInProgress = false

  $('.refresh_all_menus').click (e) ->
    e.preventDefault()

    return if refreshInProgress

    $el = $ @
    $('.alert').alert('close')

    refreshInProgress = true

    $el.children('i').addClass('fa-spin')

    promises = menus.map (i, m) -> $.get m.href

    $.when.apply($, promises).then ->
      $('#alerts').append '<div class="alert alert-success"><button type="button" class="close" data-dismiss="alert">&times;</button>Menus refreshed</div>'
      $el.children('i').removeClass('fa-spin')
      refreshInProgress = false
