class VisualizationsController < ApplicationController

      def all
      	@info = "Info"    
      	@stacks = Stack.all(reload = false)
      end

      def backbone
      	# uses the JSON data returned from the API
      end
end
