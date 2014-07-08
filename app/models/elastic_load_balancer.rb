require './lib/ops_works_wrapper'

class ElasticLoadBalancer
    attr_reader :elb_id, :region, :availability_zones

    def initialize(elb_id, opts)
    	return if !elb_id

	@elb_id = elb_id
	@region = opts[:region]
	@availability_zones = opts[:availability_zones]
    end
end