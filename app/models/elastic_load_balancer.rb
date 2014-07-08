require './lib/ops_works_wrapper'

class ElasticLoadBalancer
    attr_reader :id, :region, :availability_zones

    def initialize(id, opts)
    	return if !id

		@id = id
		@region = opts[:region]
		@availability_zones = opts[:availability_zones]
    end
end