require './lib/ops_works_wrapper'

class Layer
      attr_reader :layer_id, :type, :name

      def initialize(layer_id, opts = {})
      	return if !layer_id
	
	@layer_id = layer_id
	@type = opts[:type]
	@name = opts[:name]
      end
end