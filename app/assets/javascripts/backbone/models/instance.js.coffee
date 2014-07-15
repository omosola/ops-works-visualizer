class OpsWorksVisualization.Models.Instance extends Backbone.Model
  paramRoot: 'instance'

  defaults:
    id: null
    hostname: null
    status: null
    os: null
    type: null
    availability_zone: null
    public_ip: null
    layer_ids: null

class OpsWorksVisualization.Collections.InstancesCollection extends Backbone.Collection
  model: OpsWorksVisualization.Models.Instance
  url: '/instances'
