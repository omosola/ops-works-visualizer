require './lib/ops_works_wrapper'

class Instance

	attr_reader :id, :hostname, :status, :os, :type, :availability_zone, :public_ip, :layer_ids

	def initialize(id, opts = {})
		return if !id

		@id = id
		@hostname = opts[:hostname]
		@status = opts[:status]
		@os = opts[:os]
		@type = opts[:virtualization_type]
		@availability_zone = opts[:availability_zone]
		@public_ip = opts[:public_ip]
		@layer_ids = opts[:layer_ids]
	end
end