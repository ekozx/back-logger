# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#TODO: turbolinks spinner
$ ->
  $("a.deleteEntry[data-remote]").on 'mousedown', (event) ->
    console.log("mousedown")
    $(@).parent().append("deleting...")
  $("a.deleteEntry[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    console.log("ajax success")
    $(@).parent().hide()
    $(@).parent().append("deleted!")
