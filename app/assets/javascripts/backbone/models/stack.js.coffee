class OpsWorksVisualization.Models.Stack extends Backbone.Model
  paramRoot: 'stack'

  defaults:
    id: null
    name: null
    hostname: null
    default_os: null
    default_az: null
    elbs: null
    instances: null
    layers: null

class OpsWorksVisualization.Collections.StacksCollection extends Backbone.Collection
  model: OpsWorksVisualization.Models.Stack
  url: '/stacks'
