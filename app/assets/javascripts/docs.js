// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('turbolinks:load', function() {
  $('#doc-steps').bootstrapWizard();

  function recalculatePositionAndSubmitAfterItemMoved(movedItem) {
    $(movedItem)
    .closest('.sortable')
    .find('input.item-position')
    .each(function(index, input) {
      $(input).val(index)
    })

    $(movedItem).closest('form').submit()
  }

  $('.item-list .sortable').each(function(index, element) {
    Sortable.create(element, {
      onSort: function (event) {
        recalculatePositionAndSubmitAfterItemMoved(event.item)
      }
    })
  })

  $('.move-up').on('click', function() {
    var item = $(this).closest('.item')
    item.insertBefore(item.prevAll('.item')[0])
    recalculatePositionAndSubmitAfterItemMoved(item)
  })
  $('.move-down').on('click', function() {
    var item = $(this).closest('.item')
    item.insertAfter(item.nextAll('.item')[0])
    recalculatePositionAndSubmitAfterItemMoved(item)
  })
})

;(function() {
  var currentScroll = 0
    , currentTab = 0

  addEventListener("turbolinks:before-render", function() {
    currentScroll = document.documentElement.scrollTop || document.body.scrollTop
    currentTab = $('#doc-steps').bootstrapWizard('currentIndex')
  })

  addEventListener("turbolinks:render", function() {
    document.documentElement.scrollTop = document.body.scrollTop = currentScroll
    $('#doc-steps').bootstrapWizard()
    $('#doc-steps').bootstrapWizard('show', currentTab)
  })

})();
