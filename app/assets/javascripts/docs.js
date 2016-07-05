// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('turbolinks:load', function() {
  $('.sorted-list .sortable').each(function(index, element) {
    Sortable.create(element, {
      onSort: function (event) {
        var movedItem = event.item

        $(movedItem).closest('.sortable').find('input.item-position').each(function(index, input) {
          $(input).val(index)
        })

        $(movedItem).closest('form').submit()
      }
    })
  })
})
