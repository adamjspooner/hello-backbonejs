# **This example illustrates the declaration and instantiation of a minimalist View.**
#
# _Working example: [1.html](../1.html)._
# _[Go to Example 2](2.html)_

# jQuery's document-ready function
jQuery ->
  
  # **ListView class**: Our main app view.
  class ListView extends Backbone.View
    
    el: $ 'body'
    
    # `initialize()`: Automatically called upon instantiation. Where you make all types of bindings, _excluding_ UI events, such as clicks, etc.
    initialize: ->
      _.bindAll @, 'render'
      @render()
    
    # `render()`: Function in charge of rendering the entire view in `this.el`. Needs to be manually called by the user.
    render: ->
      $(@el).append '<ul><li>Hello, World!</li></ul>'
  
  
  # **listView instance**: Instantiate main app view.
  listView = new ListView
