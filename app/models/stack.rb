require './lib/ops_works_wrapper'

class Stack

	attr_reader :id, :name, :hostname, :default_os, :default_az, :elbs, :instances, :layers

  ######################################################################################################################
  # Class methods
  ######################################################################################################################

	# caching system
	# When all stacks are requested, we clear everything previously in the cache, because we don't want
	# to store old individual stack details if we could potentially get completely new stacks from the
	# ops works call
	#
	# When we ask for individual stack info, 

	def self.all(reload = false, load_details = false)
		reload ||= false
		load_details ||= false
		
		if reload then Rails.cache.delete("all_stacks") end

		Rails.cache.fetch("all_stacks", expires_in: 15.minutes) do
			Rails.cache.clear # get rid of all old stack information (instances, elbs, layers, etc)
			self.load_stacks(load_details)
		end
	end

	## private helper method
	def self.load_stacks(load_details)
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
			# create a new Stack object for each stack in the AWS_OpsWorks JSON response
			Stack::new(id, opts)
		end

		stacks.each(&:load_all_stack_info) if load_details
		puts stacks
		stacks
	end

	def self.find(id)
		Rails.cache.fetch("stack_#{id}", expires_in: 15.minutes) do
			stack = Stack.all.find { |stack| stack.id == id }
			stack.load_all_stack_info if stack
			stack
		end
	end

  ######################################################################################################################
  # Instance methods
  ######################################################################################################################

  	# Stack object initializer
	def initialize(id, opts = {})
		return if !id

		@id = id
		@name = opts[:name]
		@hostname = opts[:hostname]
		@default_os = opts[:default_os]
		@default_az = opts[:default_az] # availability zone
	end

	def load_all_stack_info
		self.load_instances
		self.load_layers
		self.associate_instances_with_layers
		self.load_elastic_load_balancers
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
