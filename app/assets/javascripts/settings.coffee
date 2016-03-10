$ ->
  $('[data-toggle="toggle"]').change ->
    el = $(@)
    saveSetting(el.data('name'), el.prop('checked'), el.parent().parent().parent().parent())

  $('#save_sr').click ->
    el = $(@).parent().parent()
    saveSetting('shortreckonings_id', $('#sr_id').val(), el)

saveSetting = (name, value, el) ->
  $.ajax
      type: 'POST'
      url: '/settings'
      data:
        name: name
        value: value
      success: ->
        el.addClass 'success'
          .delay 2000
          .queue (next) ->
            el.removeClass 'success'
            next()
