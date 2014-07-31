# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#TODO: turbolinks spinner
$ ->
  # $('.entry').on 'click', (event) ->
  #   $(@).parent().parent().hide()
  #   url = "entries/remove/" + $(@).data("id")
  #   console.log($(@).data("id"))
  #   console.log(url)
  #   $.ajax url,
  #     type: "GET",
  #     dataType: "json",
  #     success: (response) ->
  #       console.log(response)

  $("a.deleteEntry[data-remote]").on 'mousedown', (event) ->
    console.log("mousedown")
    $(@).parent().append("deleting...")
  $("a.deleteEntry[data-remote]").on "ajax:success", (e, data, status, xhr) ->
    console.log("ajax success")
    $(@).parent().hide()
    $(@).parent().append("deleted!")
