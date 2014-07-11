OpsWorksVisualization.Views.Stacks ||= {}

class OpsWorksVisualization.Views.Stacks.IndexView extends Backbone.View
  template: JST["backbone/templates/stacks/index"]

  initialize: () ->
    @options.stacks.bind('reset', @addAll)

  addAll: () =>
    @options.stacks.each(@addOne)

  addOne: (stack) =>
    view = new OpsWorksVisualization.Views.Stacks.StackView({model : stack})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(stacks: @options.stacks.toJSON() ))
    @addAll()

    return this
