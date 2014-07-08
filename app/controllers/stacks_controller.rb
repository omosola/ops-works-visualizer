class StacksController < ApplicationController

	def index
		@stacks = Stack.all(reload = false)
		puts @stacks.to_json
	end

	def show
		@stacks = Stack.find(params[:id])
		puts @stacks
	end
end
