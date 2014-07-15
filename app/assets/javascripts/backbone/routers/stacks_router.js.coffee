class OpsWorksVisualization.Routers.StacksRouter extends Backbone.Router
  initialize: (options) ->
    @stacks = new OpsWorksVisualization.Collections.StacksCollection()
    @stacks.reset options.stacks

  routes:
    "new"      : "newStack"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newStack: ->
    @view = new OpsWorksVisualization.Views.Stacks.NewView(collection: @stacks)
    $("#stacks").html(@view.render().el)

  index: ->
    @view = new OpsWorksVisualization.Views.Stacks.IndexView(stacks: @stacks)
    $("#stacks").html(@view.render().el)

  show: (id) ->
    stack = @stacks.get(id)

    @view = new OpsWorksVisualization.Views.Stacks.ShowView(model: stack)
    $("#stacks").html(@view.render().el)

  edit: (id) ->
    stack = @stacks.get(id)

    @view = new OpsWorksVisualization.Views.Stacks.EditView(model: stack)
    $("#stacks").html(@view.render().el)
