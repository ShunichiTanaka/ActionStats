# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.publish_all_class').change ->
    $('.publish_all_button').each ->
      $(this).attr('disabled', unchecked_all())

  unchecked_all = ->
    ret = true
    $('.publish_all_class').each ->
      if $(this).prop('checked')
        ret = false
        return false
    ret
