class StacksController < ApplicationController

	def index
		@stacks = Stack.all(params[:reload])
		puts @stacks.to_json
	end

	def show
		# TODO
		@stack = Stack.find(params[:id]) || not_found
	end

	def not_found
		redirect_to public_path("404.html")
	end
end
