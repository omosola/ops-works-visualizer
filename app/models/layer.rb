require './lib/ops_works_wrapper'

class Layer
	attr_accessor :id, :type, :name, :instances

	def initialize(id, opts = {})
		return if !id

		@id = id
		@type = opts[:type]
		@name = opts[:name]
	end
end