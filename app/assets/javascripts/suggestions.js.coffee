# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
# $(':radio').change(
#   function(){
#     $('.choice').text( this.value + ' stars' );
#   }
# )
$ ->
  $(':radio').on 'change', (event) ->
    $('.choice').text(this.val + ' stars')
