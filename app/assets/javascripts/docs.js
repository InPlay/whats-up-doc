// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

App.docStuff = function() {
  $('#doc-steps').bootstrapWizard();

  $('a[data-toggle="editable"]').on('click', function(e) {
    var link = $(e.target)
      , target = $(link.data().target)

    e.preventDefault();
    e.stopPropagation();

    if (target.hasClass('not-editable')) {
      target.removeClass('not-editable').addClass('editable')
      target.find('input').prop( "disabled", false )
      link.hasClass('btn-edit') ? link.addClass('active') : undefined
    } else if (target.hasClass('editable')) {
      target.removeClass('editable').addClass('not-editable')
      link.hasClass('btn-edit') ? link.removeClass('active') : undefined
      target.closest('form').submit()
    }
  })

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
      filter: '.move-up, .move-down', // otherwise moving via buttons breaks sortable
      onSort: function (event) {
        recalculatePositionAndSubmitAfterItemMoved(event.item)
      }
    })
  })

  var clickEvent = $.support.touch ? "tap" : "click";

  $('.move-up').on(clickEvent, function() {
    var item = $(this).closest('.item')
    item.insertBefore(item.prevAll('.item')[0])
    recalculatePositionAndSubmitAfterItemMoved(item)
  })

  $('.move-down').on(clickEvent, function() {
    var item = $(this).closest('.item')
    item.insertAfter(item.nextAll('.item')[0])
    recalculatePositionAndSubmitAfterItemMoved(item)
  })

  setTimeout(function() {
    $('.notice-icon').fadeOut();
  }, 500);

  App.makeChart()
}

App.makeChart = function() {
  var chartData = JSON.parse($('#chart .data').text())
    , itemCount = $('#chart .data').data().itemCount
    , xScale = d3.scaleLinear()
      .domain([0, itemCount - 1])
      .range([640, 20])
    , yScale = d3.scaleLinear()
      .domain([0, itemCount - 1])
      .range([20, 520])
    , svg = d3.select('#chart').append('svg')
      .attr('width', 750)
      .attr('height', 550)
    , xAxis = d3.axisLeft()
    , yAxis = d3.axisBottom()
    , text = svg.selectAll('text').data(chartData).enter().append('text')

  // graph the items
  text
  .attr('x', function(d) { return xScale(d.x) })
  .attr('y', function(d) { return yScale(d.y) })
  .text(function(d) { return d.text })

  // add sticky-note boxes
  svg.selectAll('text').each(function() {
    var bbox = this.getBBox();
    var padding = 8;
    var rect = svg.insert("rect", "text")
        .attr("x", bbox.x - padding)
        .attr("y", bbox.y - 8)
        .attr("width", bbox.width + (padding*2))
        .attr("height", bbox.height + (padding*2))
        .style("fill", "#FFCC22")
        .attr('transform', "rotate(0.2)")
  })

  // x "axis"
  svg.insert('line', 'rect')
  .attr('x1', 0)
  .attr('y1', yScale((itemCount - 1)/2))
  .attr('x2', 750)
  .attr('y2', yScale((itemCount - 1)/2))
  .attr("stroke-width", 2)
  .attr("stroke", "black");

  svg.insert('text', 'rect')
  .attr('x', 625)
  .attr('y', yScale((itemCount - 1)/2) - 10)
  .text('Implementation')
  .attr('style', 'font-size: 18px')

  svg.insert('text', 'rect')
  .attr('x', 715)
  .attr('y', yScale((itemCount - 1)/2) + 20)
  .text('Easy')
  .attr('style', 'font-style: italic')

  svg.insert('text', 'rect')
  .attr('x', 05)
  .attr('y', yScale((itemCount - 1)/2) + 20)
  .text('Hard')
  .attr('style', 'font-style: italic')

  // y "axis"
  svg.insert('line', 'rect')
  .attr('x1', xScale((itemCount - 1)/2) + 40)
  .attr('y1', 0)
  .attr('x2', xScale((itemCount - 1)/2) + 40)
  .attr('y2', 550)
  .attr("stroke-width", 2)
  .attr("stroke", "black");

  svg.insert('text', 'rect')
  .attr('x', yScale((itemCount - 1)/2) + 35)
  .attr('y', 15)
  .text('Impact')
  .attr('style', 'font-size: 18px')

  svg.insert('text', 'rect')
  .attr('x', yScale((itemCount - 1)/2) + 110)
  .attr('y', 15)
  .text('High')
  .attr('style', 'font-style: italic')

  svg.insert('text', 'rect')
  .attr('x', yScale((itemCount - 1)/2) + 110)
  .attr('y', 545)
  .text('Low')
  .attr('style', 'font-style: italic')

}

;(function() {
  var currentScroll = 0
    , currentTab = 0
    , currentAddItemContent

  addEventListener("turbolinks:before-render", function() {
    if (!$('body').hasClass('docs show')) return

    currentScroll = document.documentElement.scrollTop || document.body.scrollTop
    currentTab = $('#doc-steps').bootstrapWizard('currentIndex')
    currentAddItemContent = $('#doc_add_item_content').val()
  })

  addEventListener("turbolinks:render", function() {
    if (!$('body').hasClass('docs show')) return

    document.documentElement.scrollTop = document.body.scrollTop = currentScroll
    $('#doc-steps').bootstrapWizard()
    $('#doc-steps').bootstrapWizard('show', currentTab)
    $('#doc_add_item_content').val(currentAddItemContent)
  })
})();

$(document).on('turbolinks:load', function() {
  if (!$('body').hasClass('docs show')) return

  $(document).on('ajax:success', function() {
    $('#new-item input[type="text"]').val('')
  })

  App.docStuff()
});

