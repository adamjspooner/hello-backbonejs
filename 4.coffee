# **This example illustrates how to delegate the rendering of a Model to a dedicated View.**
#
# _Working example: [4.html](../4.html)._  
# _[Go to Example 5](5.html)_

#
jQuery ->
  
  class Item extends Backbone.Model
    
    defaults:
      part1: 'hello'
      part2: 'world'
  
  
  class List extends Backbone.Collection
    
    model: Item
  
  
  # **ItemView class**: Responsible for rendering each individual `Item`.
  class ItemView extends Backbone.View
    
    tagName: 'li'
    
    initialize: ->
      _.bindAll @
    
    render: ->
      $(@el).html "<span>#{@model.get 'part1'} #{@model.get 'part2'}</span>"
      @
  
  
  class ListView extends Backbone.View
    
    el: $ 'body'
    
    initialize: ->
      _.bindAll @
      
      @collection = new List
      @collection.bind 'add', @appendItem
      
      @counter = 0
      @render()
    
    render: ->
      $(@el).append '<button>Add List Item</button>'
      $(@el).append '<ul></ul>'
      _.each @collection.models, (item) -> appendItem item
    
    addItem: ->
      @counter++
      item = new Item
      item.set part2: "#{item.get 'part2'} #{@counter}"
      @collection.add item
    
    # `appendItem()` is no longer responsible for rendering an individual `Item`. This is now delegated to the `render()` method of each `ItemView` instance.
    appendItem: (item) ->
      itemView = new ItemView model: item
      $('ul').append itemView.render().el
    
    events: 'click button': 'addItem'
  
  
  listView = new ListView
