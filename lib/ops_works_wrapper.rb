require 'aws-sdk'
require 'json'

class OpsWorksWrapper

	def self.client
		self.aws_config
		AWS::OpsWorks.new.client
	end

	def self.aws_config
		abort <<-END_OF_STRING unless ENV['AWS_ACCESS_KEY_ID'] && ENV['AWS_SECRET_ACCESS_KEY']
	Missing OpsWorks API token. Set AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY environment variable:
		echo "export AWS_ACCESS_KEY_ID=your_aws_access_key_id" >> ~/.profile
		echo "export AWS_SECRET_ACCESS_KEY=your_aws_secret_access_key" >> ~/.profile
		. ~/.profile
  		END_OF_STRING

  		AWS.config(access_key_id: ENV['AWS_ACCESS_KEY_ID'], secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'])
	end

	def self.ops_works_config
		YAML.load_file("config/ops_works.yaml")[rails_env]
	end

end