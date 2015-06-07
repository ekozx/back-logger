#TODO: official coffeescript style is camel case... Gotta fix some stuff.. *sigh*
$ ->
  populateZapFormEntry = (zapTitle, entryId, context) ->
    $('#zap_title').val(zapTitle)
    $('#entry_id').val(entryId)
    $('.zap-pair-entry').append(context)
  populateZapFormUser = (zap_username, receiver_id, context) ->
    $('#zap_username').val(zap_username)
    $('#receiver_id').val(receiver_id)
    $('.zap-pair-user').append(context)

  $('#submit_zap').on 'click', (event) ->
    receiver_id  = $('#receiver_id').val()
    entry_id = $('#entry_id').val()
    if receiver_id == "" or entry_id == "" or receiver_id == null or entry_id == null
      event.preventDefault()
      alert('Please select a movie and friend')

  $('.suggested-friend').on 'click', (event) ->
    event.preventDefault()
    console.log(this)
    classList = this.className.split(" ")
    populateZapFormUser(classList[3], classList[2], this)

  $('.suggested-zap').on 'click', (event) ->
    event.preventDefault()
    console.log(this)
    classList = this.className.split(" ")
    populateZapFormEntry($(this).parent()[0].id, classList[2], this)
