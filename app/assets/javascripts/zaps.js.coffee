$ ->
  $('#submit_zap').on 'click', (event) ->
    receiver_id  = $('#receiver_id').val()
    entry_id = $('#entry_id').val()
    console.log(entry_id)
    console.log(receiver_id)
    if receiver_id == "" or entry_id == "" or receiver_id == null or entry_id == null
      event.preventDefault()
      alert('Please select a movie and friend')
    
