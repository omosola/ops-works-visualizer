class OpsWorksVisualization.Models.Layer extends Backbone.Model
  paramRoot: 'layer'

  defaults:
    id: null
    type: null
    name: null

class OpsWorksVisualization.Collections.LayersCollection extends Backbone.Collection
  model: OpsWorksVisualization.Models.Layer
  url: '/layers'
