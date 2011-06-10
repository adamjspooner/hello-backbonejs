# **This example illustrates how to use a Collection of Models to store data, and how to tie changes in those to a View.**
#
# _Working example: [3.html](../3.html)._  
# _[Go to Example 4](4.html)_

#
jQuery ->
  
  # **Item class**: The atomic part of our Model. A model is basically a Javascript object, i.e. key-value pairs, with some helper functions to handle event triggering, persistence, etc.
  class Item extends Backbone.Model
    
    defaults:
      part1: 'hello'
      part2: 'world'
  
  
  # **List class**: A collection of `Item`s. Basically an array of Model objects with some helper functions.
  class List extends Backbone.Collection
    
    model: Item
  
  
  class ListView extends Backbone.View
    
    el: $ 'body'
    
    # `initialize()` now instantiates a Collection, and binds its `add` event to own method `appendItem`. (Recall that Backbone doesn't offer a separate Controller for bindings...).
    initialize: ->
      _.bindAll @
      
      @collection = new List
      @collection.bind 'add', @appendItem
      
      @counter = 0
      @render()
    
    render: ->
      $(@el).append '<button>Add List Item</button>'
      $(@el).append '<ul></ul>'
    
    # `addItem()` now deals solely with models/collections. View updates are delegated to the `add` event listener `appendItem()` below.
    addItem: ->
      @counter++
      
      item = new Item
      item.set
        part2: "#{item.get('part2')} #{@counter}"
      @collection.add item
    
    # `appendItem()` is triggered by the collection event `add`, and handles the visual update.
    appendItem: (item) ->
      $('ul').append "<li>#{item.get 'part1'} #{item.get 'part2'}</li>"
    
    events: 'click button': 'addItem'
  
  
  listView = new ListView
