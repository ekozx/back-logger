$ ->
  $('#submit_zap').on 'click', (event) ->
    receiver_id  = $('#receiver_id').val()
    entry_id = $('#entry_id').val()
    if !!receiver_id or !!entry_id
      console.log("empty id")
      event.preventDefault()
      alert('Please select a movie and friend')
