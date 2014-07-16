# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $("#new_entry").on("ajax:success", (e, data, status, xhr) ->
    $("#new_entry").append "<p>posted!</p>"
  ).on "ajax:error", (e, xhr, status, error) ->
    $("#new_entry").append "<p>ERROR</p>"
  # TODO: clicking submit isn't processed correctly
  # $('.submitEntry').on 'click', (event) ->
  #   event.preventDefault()
  #
