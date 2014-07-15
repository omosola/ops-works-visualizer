OpsWorksVisualization.Views.Stacks ||= {}

class OpsWorksVisualization.Views.Stacks.StackView extends Backbone.View
  template: JST["backbone/templates/stacks/stack"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
