class Api::V1::StacksController < ApplicationController
	
	# GET /stacks
	def index
		@stacks = Stack.all params[:reload]
		render :json => @stacks
	end

	# GET /stacks/:id
	def show
		@stack = Stack.find params[:id]
		render :json => @stack
	end
end
