class VisualizationsController < ApplicationController

      def all
      	  @info = "Info"    
      	  @stacks = Stack.all(reload = false) * 2 
      end
end
