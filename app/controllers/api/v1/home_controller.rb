class Api::V1::HomeController < ApplicationController

      def index
      	  # load stack info for visualization
          @stacks = Stack.all(reload = false)
      end
end
