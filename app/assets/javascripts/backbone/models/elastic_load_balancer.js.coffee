class OpsWorksVisualization.Models.ElasticLoadBalancer extends Backbone.Model
  paramRoot: 'elastic_load_balancer'

  defaults:
    name: null
    region: null
    availability_zone: null
    instances: null
    layers: null

class OpsWorksVisualization.Collections.ElasticLoadBalancersCollection extends Backbone.Collection
  model: OpsWorksVisualization.Models.ElasticLoadBalancer
  url: '/elastic_load_balancers'
