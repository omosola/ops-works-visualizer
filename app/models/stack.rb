require './lib/ops_works_wrapper'

class Stack

  ######################################################################################################################
  # TODO Items:
  # 1) OpsWOrksWrapper: 				Rethink using OpsWorksWrapper (only used so I don't have the aws opsworks intialization
  # 									tied to the Stack model)
  # 2) Self.find: 						Work on bsearch. It shouldn't be called on a nil object since I'm checking if
  # 									all_stacks has a value first, but somehow it is!
  # 3) load_layers, etc: 				Come up with a better name than load_*, I want something more like get_layers
  # 									but it won't actually act as a getter, since I already have that from
  # 									attr_reader :layers
  # 4) associate_instances_with_layers:	Yuck, don't like the way I'ma dding instances to the layers
  # 5) associate_instances_with_layers: Don't like the name add_instances_to_layers
  # 6) load_*: 							Right now, the only thing that can be reloaded is the whole list of stack,
  # 									not the layers, instances, elbs, or individual stacks.
  # 7) associate_instances_with_layers:	Write this in more of a functional style
  ######################################################################################################################

	attr_reader :id, :name, :hostname, :default_os, :default_az, :elbs, :instances, :layers

  ######################################################################################################################
  # Class methods
  ######################################################################################################################

	def self.all(reload = false)
		if reload then Rails.cache.delete("all_stacks") end

		Rails.cache.fetch("all_stacks", expires_in: 15.minutes) do
			self.load_stacks
		end
	end

	## WORK IN PROGRESS
	def self.find(id)
		all_stacks = Rails.cache.fetch("all_stacks")
		if !all_stacks
			# OpsWorksWrapper::client.describe_stacks(ids: Array(id)).data[:stacks]
		else
			all_stacks.bsearch{ |x| x.id == id }
		end
	end

	# private helper method
	def self.load_stacks
		stacks = OpsWorksWrapper::client.describe_stacks.data[:stacks]

		# returns all of the stacks converted from hashes (response from OpsWorks API) into Stack objects
		stacks.map! do |stack|
			id = stack[:stack_id]
			opts = { 
				name: stack[:name],
				hostname: stack[:hostname_theme],
				default_os: stack[:default_os], 
				default_az: stack[:default_availability_zone]
			}
			# create a new Stack object for each stack in the AWS_OW JSON response
			Stack::new(id, opts)
		end

		stacks.each do |stack|
			stack.load_instances
			stack.load_layers
			stack.associate_instances_with_layers
			stack.load_elastic_load_balancers
		end
	end


  ######################################################################################################################
  # Instance methods
  ######################################################################################################################

	def initialize(id, opts = {})
		return if !id

		@id = id
		@name = opts[:name]
		@hostname = opts[:hostname]
		@default_os = opts[:default_os]
		@default_az = opts[:default_az] # availability zone
	end

	def load_layers
		@layers = OpsWorksWrapper::client.describe_layers(stack_id: @id).data[:layers]

		# Convert the hashes returned from the API call into Layer objects
		@layers.map! do |layer|
			layer_id = layer[:layer_id]
			opts = {
				type: layer[:type],
				name: layer[:name]
			}
			Layer.new(layer_id, opts)
		end
	end

	def load_instances
		@instances = OpsWorksWrapper::client.describe_instances(stack_id: @id).data[:instances]

		# Convert the hashes returned from the API call into Instance objects
		@instances.map! do |instance|
			instance_id = instance[:instance_id]
			opts = {
				hostname: instance[:hostname],
				status: instance[:status],
				os: instance[:os],
				instance_type: instance[:instance_type],
				availability_zone: instance[:availability_zone],
				public_ip: instance[:public_ip],
				layer_ids: instance[:layer_ids]
			}
			Instance.new(instance_id, opts)
		end
	end 

	def associate_instances_with_layers
		@layers.each do |layer|
			layer.instances = @instances.find_all { |instance| instance.layer_ids.include? layer.id }
		end
	end

	def load_elastic_load_balancers
		@elbs = OpsWorksWrapper::client.describe_elastic_load_balancers(stack_id: @id).data[:elastic_load_balancers]

		# Convert the hashes returned from the API call into ElasticLoadBalancer objects
		@elbs.map! do |elb|
			elb_name = elb[:elastic_load_balancer_name]
			opts = {
				region: elb[:region],
				availability_zone: elb[:availability_zone]
			}
			ElasticLoadBalancer.new(elb_name, opts)
		end
	end
end