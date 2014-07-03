require 'aws-sdk'
require 'json'

def aws_config
  abort <<-END_OF_STRING unless ENV['AWS_ACCESS_KEY_ID'] && ENV['AWS_SECRET_ACCESS_KEY']
Missing OpsWorks API token. Set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variable:
	echo "export AWS_ACCESS_KEY_ID=your_aws_access_key_id" >> ~/.profile
	echo "export AWS_SECRET_ACCESS_KEY=your_aws_secret_access_key" >> ~/.profile
	. ~/.profile
  END_OF_STRING

  AWS.config(access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
end

def ops_works_config
  YAML.load_file("config/ops_works.yaml")[rails_env]
end

def ops_works_client
  # TODO: Not sure why this needs to be set up each time ops_works_client is called (should be stored somewhere, right)
  # why make a new client for each call?
  aws_config 
  AWS::OpsWorks.new.client
end

def load_stack(stack_id)
  puts "load_stack"
  stack = ops_works_client.describe_stacks(stack_ids: Array(stack_id)).
                  data[:stack].detect { |app| app[:stack_id] == stack_id }
  # stack.update(custom_json: JSON.parse(stack[:custom_json]).with_indifferent_access)
end

def load_layer(stack_id)
  puts "load_layers"
  ops_works_client.describe_layers(stack_id: stack_id).data[:layers]
end

def load_app(app_id)
  puts "load_app"
  ops_works_client.describe_apps(app_ids: Array(app_id)).
                  data[:apps].detect { |app| app[:app_id] == app_id }
end

def load_layer_instances(layer_id)
  ops_works_client.describe_instances(layer_id: layer_id)
end

def load_stack_instances(stack_id)
  ops_works_client.describe_instance(stack_id: stack_id)
end

def load_stacks
  puts "load_all_stacks"
  # returns info for all stacks when
  # called w/o specific stack ids
  ops_works_client.describe_stacks
end





stacks = load_stacks
layers = 


# get_layers

=begin
describe_apps
describe_commands
describe_deployments
describe_elastic_ips
describe_elastic_load_balancers
describe_instances
describe_layers
describe_load_based_auto_scaling
describe_my_user_profile
describe_permissions
describe_stack_summary
describe_stacks
describe_rds_db_instances
describe_raid_arrays
describe_time_based_auto_scaling
describe_user_profiles
describe_volumes



def pretty_print_aws_response(response, response_type_sym)
  puts "calling pretty_print_aws_response"
  response[response_type_sym].each_with_index do |response_type_instance, index|
    puts "#{response_type_sym} #{index}"
    response_type_instance.each do |key, value|
      puts "#{key}: #{value}"
    end
    puts "\n\n\n"
  end
end

def load_stacks
  puts "getting all stacks from aws"
  stacks = ops_works_client.describe_stacks[:stacks]

  puts "getting layer info for each stack"

  stacks.each do |stack|
    puts "Layers for stack: \"#{stack[:name]}\""
    layers = load_layers stack[:id]
    layers.each do |layer|

    end
  end

  

  stack_id = stacks.first[:stack_id]
  layers = load_layers stack_id

  layers = load_layers stacks.first[:stack_id]
  # pretty_print_json_kvps layers.first
  
  puts "getting instance info for each layer"
  puts "Instances for layer \"#{layers.first[:name]}\""
  puts layers.first[:layer_id]
  puts load_instances layers.first[:layer_id]
end

def pretty_print_json_kvps(json_blob)
  json_blob.each do |key, value|
    puts "#{key}: #{value}"
  end
end

=end

