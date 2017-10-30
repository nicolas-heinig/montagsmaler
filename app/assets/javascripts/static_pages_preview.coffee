parser = new showdown.Converter()

$(document).on("turbolinks:load", ->
  makePreview()

  $('#static_page_content').on('turbolinks:load input change propertychange', ->
    makePreview()
  )

  $('#static_page_markup_type').on('change', ->
    makePreview()
  )
)

makePreview = ->
  current_content = $('#static_page_content').val()
  preview_content = ''

  if markupTypeIsMarkdown()
    preview_content = parser.makeHtml(current_content)
  else
    preview_content = current_content

  $('#preview').html(preview_content)

markupTypeIsMarkdown = ->
  $('#static_page_markup_type').find(":selected").text() == 'markdown'
