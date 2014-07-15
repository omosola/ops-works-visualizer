class ElasticLoadBalancer
	
    attr_reader :name, :region, :availability_zones

    def initialize(name, opts)
    	return if !name

		@name = name
		@region = opts[:region]
		@availability_zones = opts[:availability_zones]
    end
end