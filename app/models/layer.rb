class Layer

	attr_reader :id, :type, :name
	attr_accessor :instances

	def initialize(id, opts = {})
		return if !id

		@id = id
		@type = opts[:type]
		@name = opts[:name]
	end
end