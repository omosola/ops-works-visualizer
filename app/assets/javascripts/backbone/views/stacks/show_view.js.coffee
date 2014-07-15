OpsWorksVisualization.Views.Stacks ||= {}

class OpsWorksVisualization.Views.Stacks.ShowView extends Backbone.View
  template: JST["backbone/templates/stacks/show"]

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
