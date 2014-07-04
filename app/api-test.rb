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

# @ret array of all stacks (each is a hash)
def load_stacks
  # puts "loading stacks"
  ops_works_client.describe_stacks.data[:stacks]
end

def load_instances(stack_id)
  # puts "loading instances"
  ops_works_client.describe_instances(stack_id: stack_id).data[:instances]
end

def load_layers(stack_id)
  # puts "loading layers"
  ops_works_client.describe_layers(stack_id: stack_id).data[:layers]
end

def load_elbs(stack_id)
  # puts "loading elastic load balancers"
  ops_works_client.describe_elastic_load_balancers(stack_id: stack_id).data[:elastic_load_balancers]
end

def add_instance_info_to_stacks(stacks_array)
  # puts "adding instance info to stacks"
  stacks_array.each do |stack|
    instances = load_instances stack[:stack_id]
    stack.update(:instances => instances)
  end
  stacks_array
end

def add_layer_info_to_stacks(stacks_array)
  # puts "adding layer info to stacks"
  stacks_array.each do |stack|
    layers = load_layers stack[:stack_id]
    stack.update(:layers => layers)
  end
end

def add_elb_info_to_stacks(stacks_array)
  # puts "adding elastic load balancer info to stacks"
  stacks_array.each do |stack|
    elastic_load_balancers = load_elbs stack[:stack_id]
    stack.update(:elbs => elastic_load_balancers)
  end
end

def print_stacks_info(stacks_array)
  stacks_array.each_with_index do |stack, index|
    puts "Stack ##{index}"
    puts "\tName #{stack[:name]}"
    puts "\tELBs"
    stack[:elbs].each_with_index do |elb, index|
      puts "\t\t#{index}"
      puts "\t\tName: #{elb[:elastic_load_balancers]}"
      puts "\t\tRegion: #{elb[:region]}"
      puts "\t\tDNS Name: #{elb[:dns_name]}"
    end
    puts "\tInstances"
    stack[:instances].each_with_index do |instance, index|
      puts "\t\t#{index}"
      puts "\t\tLayer Ids: #{instance[:layer_ids]}"
      puts "\t\tHostname: #{instance[:hostname]}"
    end
    puts "\tLayers"
    stack[:layers].each_with_index do |layer, index|
      puts "\t\t#{index}"
      puts "\t\tName: #{layer[:name]}"
      puts "\t\tDescription: #{layer[:description]}"
      puts "\t\tType: #{layer[:type]}"
      puts "\t\tDomains: #{layer[:domains]}"
      puts "\t\tCreated At: #{layer[:created_at]}"
    end
  end
end

def get_all_stack_info
  stacks = load_stacks
  stacks = add_instance_info_to_stacks stacks
  stacks = add_layer_info_to_stacks stacks
  stacks = add_elb_info_to_stacks stacks
  stacks
end

print_stacks_info get_all_stack_info
