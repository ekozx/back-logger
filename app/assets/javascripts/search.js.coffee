# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $('.depth').on 'click', (event) ->
    $('.loading').show()
    $('.pagination').show()

  $('#search').on 'keypress', (event) ->
    keycode = event.keyCode
    type = $('input[name=group]:checked').val()
    url = "search/" + type + "/" + $('#search').children().first().val() + "/no"
    list = $('#list')
    entries = list.children()
    entry.remove() for entry in entries
    $('.pagination').hide()
    $('.loading').hide()
    if url != 'search/users/' or url != 'search/entries/' or keycode != 13
      $.ajax url,
        type: 'GET',
        error: (jqXHR, textStatus, errorThrown) ->
        success: (data, textStatus, jqXHR) ->
          for k,v of data
            if type == 'entries'
              list.append("<li id='" + v['id'] + "'><a href='/entries/" + v['id'] + "'>" + v['title'] + "</a></li>")
            else
              console.log v['name']
              list.append("<li id='" + v['id'] + "'>" + v['name'] + "</li>")
    else if keycode == 13
      #TODO: progress bar!
      $('.loading').show()
      $('.pagination').show()
