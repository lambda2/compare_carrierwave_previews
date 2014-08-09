# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("[data-preview]").hover ->
    console.log("Hover")
    setTimeout =>
      current = parseInt($(@).attr("src").split("_").slice(-1)) + 10
      console.log("current percentage => #{current}")
      $(@).attr("src", "#{$(@).attr('data-preview')}_#{current % 110}")
      $(@).trigger("hover")
    , 1000
