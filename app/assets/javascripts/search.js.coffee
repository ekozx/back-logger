# # Place all the behaviors and hooks related to the matching controller here.
# # All this logic will automatically be available in application.js.
# # You can use CoffeeScript in this file: http://coffeescript.org/
#
# # if keycode == 13
# #   url += "/tomatoes"
# # else
# #   url += "/none"
#
# $ ->
#   $('#search').on 'keypress', (event) ->
#     #TODO: add some stall-time so that there are fewer queries to amazon
#     # keycode = event.keyCode
#     type = $('input[name=group]:checked').val()
#     url = "search/" + type + "/" + $('#search').children().first().val() + "/no"
#     list = $('#list')
#     entries = list.children()
#     entry.remove() for entry in entries
#     if url != 'search/users/' or url != 'search/entries/'
#       $.ajax url,
#         type: 'GET',
#         error: (jqXHR, textStatus, errorThrown) ->
#         success: (data, textStatus, jqXHR) ->
#           for k,v of data
#             if type == 'entries'
#               list.append("<li id='" + v['id'] + "'>" + v['title'] + "</li>")
#             else
#               console.log v['name']
#               list.append("<li id='" + v['id'] + "'>" + v['name'] + "</li>")
