$ ->
  $('[data-toggle="tooltip"]').tooltip()

  if $('#comments').length
    scrollCommentsToBottom()

  if $('#balance-table').length
    showBalanceData()

showBalanceData = () ->
  $table = $('#balance-table')
  $.get '/balances'
    .done (data) ->
      $table.html '<tr><th>Name</th><th class="text-right">Balance</th></tr>'
      for balance in data
        tr = $('<tr />')
        tr.append $('<td />').text(balance.name)

        td = $('<td />').addClass('text-right').text(balance.balance + ' €')
        td.addClass if balance.balance < 0 then 'text-danger' else 'text-success'
        tr.append td

        $table.append tr
    .fail ->
      $table.html '<tr><td>There was an error</td></tr>'

scrollCommentsToBottom = () ->
  $comments = $('#comments')
  $comments.scrollTop($comments[0].scrollHeight)
