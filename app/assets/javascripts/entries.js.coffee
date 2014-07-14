# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  # $('.addEntry').on 'click', (event) ->
  #   url = "/entries/add/" + $(@).data("id")
  #   console.log($(@).data("id"))
  #   console.log(url)
  #   $.ajax url,
  #     type: "GET",
  #     dataType: "json",
  #     success: (response) ->  
  #       console.log(response)

  $("#new_entry").on("ajax:success", (e, data, status, xhr) ->
    $("#new_entry").append "<p>posted!</p>"
  ).on "ajax:error", (e, xhr, status, error) ->
    $("#new_entry").append "<p>ERROR</p>"