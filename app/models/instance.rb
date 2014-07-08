require './lib/ops_works_wrapper'

class Instance

      attr_reader :instance_id, :name, :hostname, :status, :size, :type, :availability_zone, :public_ip

      def initialize(instance_id, opts = {})
      	  return if !instance_id

	  @instance_id = instance_id
	  @name = opts[:name]
	  @hostname = opts[:hostname]
	  @status = opts[:status]
	  @size = opts[:size]
	  @type = opts[:type]
	  @availability_zone = opts[:availability_zone]
	  @public_ip = opts[:public_ip]
      end
end