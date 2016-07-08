var docSlug
;(function() {
  var parts = window.location.href.split('/');
  docSlug = parts[parts.length - 1]
})()

App.docs = App.cable.subscriptions.create({'channel': "DocsChannel", 'slug': docSlug}, {
  connected: function() {
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(data) {
    if (data['items']) {
      $('#items .list-group').html(data['items'])
    }
    if (data['impact_list']) {
      $('#impact_list .row').replaceWith($(data['impact_list']).find('.row'))
    }
    if (data['implementation_list']) {
      $('#implementation_list .row').replaceWith($(data['implementation_list']).find('.row'))
    }
    if (data['whats_up']) {
      $('#whats_up .list-group').html(data['whats_up'])
    }
    if (data['chart']) {
      $('#chart').replaceWith(data['chart'])
    }

    App.docStuff()
  }
});
