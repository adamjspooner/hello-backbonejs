# **This example illustrates the binding of DOM events to View methods.**
#
# _Working example: [2.html](../2.html)._
# _[Go to Example 3](3.html)_

#
jQuery ->
  
  class ListView extends Backbone.View
    
    el: $ 'body'
    
    initialize: ->
      _.bindAll @
      @counter = 0
      @render()
    
    # `render()` now introduces a button to add a new list item.
    render: ->
      $(@el).append '<button>Add List Item</button>'
      $(@el).append '<ul></ul>'
    
    # `addItem()`: Custom function called via `click` event above.
    addItem: ->
      @counter++
      $('ul').append "<li>Hello, World #{@counter}!</li>"
    
    # `events`: Where DOM events are bound to View methods. Backbone doesn't have a separate controller to handle such bindings; it all happens in a View.
    events: 'click button': 'addItem'
  
  
  listview = new ListView
