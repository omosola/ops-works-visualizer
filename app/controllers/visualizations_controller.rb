class VisualizationsController < ApplicationController

      def all
      	  @info = "Info"    
      	  @stacks = Stack.all(reload = false)
      end
end
