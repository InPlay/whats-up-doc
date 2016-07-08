App.docs = {}

$(document).on('turbolinks:load', function() {
  if (!$('body').hasClass('docs show')) return

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
      if (data.html) {
        // Need to figure out a way to not copy/paste this...
        currentScroll = document.documentElement.scrollTop || document.body.scrollTop
        currentTab = $('#doc-steps').bootstrapWizard('currentIndex')
        currentAddItemContent = $('#doc_add_item_content').val()

        $('body').html(data.html.match(/<body[\s\S]*body>/))

        document.documentElement.scrollTop = document.body.scrollTop = currentScroll
        $('#doc-steps').bootstrapWizard()
        $('#doc-steps').bootstrapWizard('show', currentTab)
        $('#doc_add_item_content').val(currentAddItemContent)
      }

      App.docStuff()
    }
  });
})
