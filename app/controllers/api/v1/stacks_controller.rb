class Api::V1::StacksController < ApplicationController
	
	# GET /stacks
	def index
		# possible parameters:
		# reload -> indicates whether the stack info should be reloaded or pulled from cache
		# 					where available
		# load_details -> indicates if all stack info (ELB, layers, etc) should be loaded at once
		# 		or just the basic stack information [Basic, Advanced]
		@stacks = Stack.all params[:reload], params[:detailed]
		render :json => @stacks
	end

	# GET /stacks/:id
	def show
		# if stack information hasn't been loaded yet, it will load the information for this stack
		@stack = Stack.find params[:id]
		render :json => @stack
	end
end
