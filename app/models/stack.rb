require './lib/ops_works_wrapper'

class Stack
	# include OpsWorksWrapper # provides ops_works_client access, aws-sdk; TODO: Think of the cleanest way to do this
		# mainly only doing this because I want the aws opsworks initializations to not be tied to 
		# the Stack model (especially since it needs to be callable by both Stack class methods and instance methods)

		attr_reader :id, :name, :hostname, :default_os, :default_az

		def self.all(reload = false)
			if reload then Rails.cache.delete("all_stacks") end

			Rails.cache.fetch("all_stacks", expires_in: 15.minutes) do
				# returns an array of all Stack objects
				stacks = OpsWorksWrapper::client.describe_stacks.data[:stacks]

				# returns all of the stacks converted from hashes into Stack objects
				stacks.map! do |stack|
					id = stack[:stack_id]
					opts = { 
						name: stack[:name],
						hostname: stack[:hostname_theme], # TODO: Do I really want hostname_theme??
						default_os: stack[:default_os], 
						default_az: stack[:default_availability_zone]
					}
					# create a new Stack object for each stack in the AWS_OW JSON response
					Stack::new(id, opts)
				end

			stacks.each do |stack|
				stack.load_layers
				stack.load_instances
				stack.load_elastic_load_balancers
			end
		end
		
	end

	def self.find(id)
		### TODO: Working on this part! bsearch should not be being called on a nil object
		### since I'm checking if all_stacks has a value first!!

		# returns a single stack object instance
		all_stacks = Rails.cache.fetch("all_stacks")
		if !all_stacks
			puts "no stacks"
			puts all_stacks
			# OpsWorksWrapper::client.describe_stacks(ids: Array(id)).data[:stacks]
		else
			all_stacks.bsearch{ |x| x.id == id }
		end
	end

	def initialize(id, opts = {})
		return if !id

		@id = id
		@name = opts[:name]
		@hostname = opts[:hostname]
		@default_os = opts[:default_os]
		@default_az = opts[:default_az] # availability zone
	end

	# TODO: Come up with a better name than load_* because it doesn't really make sense
	# to say "load_layers" and then say reload = false, since load_layers already
	# sounds like I'm reloading layers
	def load_layers
		@layers = OpsWorksWrapper::client.describe_layers(stack_id: @id).data[:layers]

		# returns an array of Layer objects instead of the hashes returned from the API call
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

		# returns an array of Instance objects instead of the hashes returned from the API call
		@instances.map! do |instance|
			instance_id = instance[:layer_id]
			opts = {
				name: instance[:name],
				hostname: instance[:hostname],
				status: instance[:status],
				size: instance[:size],
				type: instance[:type],
				availability_zone: instance[:availability_zone],
				public_ip: instance[:public_ip]
			}
			Instance.new(instance_id, opts)
		end
	end 

	def load_elastic_load_balancers(reload = false)
		@elbs = OpsWorksWrapper::client.describe_elastic_load_balancers(stack_id: @id).data[:elastic_load_balancers]

		# returns an array of ElasticLoadBalancer objects instead of the hashes returned from the API call
		@elbs.map! do |elb|
			elb_id = elb[:layer_id]
			opts = {
				region: elb[:region],
				availability_zone: elb[:availability_zone]
			}
			ElasticLoadBalancer.new(elb_id, opts)
		end
	end
end