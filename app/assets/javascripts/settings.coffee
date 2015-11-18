$ ->
  $('[data-toggle="toggle"]').change ->
    el = $(@)
    $.ajax
      type: 'POST'
      url: '/settings'
      data:
        name: el.data('name')
        value: el.prop('checked')
      success: ->
        tr = el.parent().parent().parent().parent()
        tr.addClass 'success'
          .delay 2000
          .queue (next) ->
            tr.removeClass 'success'
            next()
