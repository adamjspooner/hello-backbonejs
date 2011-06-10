# **This example introduces two new Model actions (swap and delete), illustrating how such actions can be handled within a Model's View.**
#
# _Working example: [5.html](../5.html)._
#
#
jQuery ->
  
  # `Backbone.sync`: Overrides persistence storage with dummy function. This enables use of `Model.destroy()` without raising an error.
  Backbone.sync = (method, model, success, error) ->
    
    success()
  
  
  class Item extends Backbone.Model
    
    defaults:
      part1: 'hello'
      part2: 'world'
  
  
  class List extends Backbone.Collection
    
    model: Item
  
  
  class ItemView extends Backbone.View
    
    tagName: 'li'
    
    # `initialize()` now binds model change/removal to the corresponding handlers below.
    initialize: ->
      _.bindAll @, 'render', 'unrender', 'swap', 'remove'
      
      @model.bind 'change', @render
      @model.bind 'remove', @unrender
    
    # `render()` now includes two extra `span`s corresponding to the actions swap and delete.
    render: ->
      $(@el).html """
        <span>#{@model.get 'part1'} #{@model.get 'part2'}</span>
        <span class="swap">swap</span>
        <span class="delete">delete</span>
      """
      @
    
    # `unrender()`: Makes Model remove itself from the DOM.
    unrender: ->
      $(@el).remove()
    
    # `swap()` will interchange an `Item`'s attributes. When the `.set()` model function is called, the event `change` will be triggered.
    swap: ->
      @model.set
        part1: @model.get 'part2'
        part2: @model.get 'part1'
    
    # `remove()`: We use the method `destroy()` to remove a model from its collection. Normally this would also delete the record from its persistent storage, but we have overridden that (see above).
    remove: -> @model.destroy()
    
    # `ItemView`s now respond to two clickable actions for each `Item`: swap and delete.
    events:
      'click .swap': 'swap'
      'click .delete': 'remove'
  
  
  # Because the new features (swap and delete) are intrinsic to each `Item`, there is no need to modify `ListView`.
  class ListView extends Backbone.View
    
    el: $ 'body'
    
    initialize: ->
      _.bindAll @, 'render', 'addItem', 'appendItem'
      
      @collection = new List
      @collection.bind 'add', @appendItem
      
      @counter = 0
      @render()
    
    render: ->
      $(@el).append '<button>Add Item List</button>'
      $(@el).append '<ul></ul>'
    
    addItem: ->
      @counter++
      item = new Item
      item.set part2: "#{item.get 'part2'} #{@counter}"
      @collection.add item
    
    appendItem: (item) ->
      itemView = new ItemView model: item
      $('ul').append itemView.render().el
    
    events: 'click button': 'addItem'
  
  
  listView = new ListView
