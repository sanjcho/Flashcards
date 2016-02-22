refresh_card = ->
  $.ajax
    type: 'get'
    url: '/home'
    dataType: 'json'
    success: (json) ->
      if json.no_card?
        $(".compare").empty()
        $("#message").text(json.message)
      else
        $("#card_exemplum").html($("<img>", {src: json.image_url}))
        $("#translated").text(json.translated_text)
        $(".card_checkout").attr('action', json.path)
        $(".card_checkout").attr('id', json.card_id)
        $("#compared_text").empty()


$ ->
  $(".card_checkout").on "ajax:complete", refresh_card