require './lib/ops_works_wrapper'

class Instance

	attr_reader :id, :name, :hostname, :status, :size, :type, :availability_zone, :public_ip

	def initialize(id, opts = {})
		return if !id

		@id = id
		@name = opts[:name]
		@hostname = opts[:hostname]
		@status = opts[:status]
		@size = opts[:size]
		@type = opts[:type]
		@availability_zone = opts[:availability_zone]
		@public_ip = opts[:public_ip]
	end
end