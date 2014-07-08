require './lib/ops_works_wrapper'

class Layer
	attr_reader :id, :type, :name

	def initialize(id, opts = {})
		return if !id

		@id = id
		@type = opts[:type]
		@name = opts[:name]
	end
end