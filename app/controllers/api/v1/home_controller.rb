class Api::V1::HomeController < ApplicationController

  def index

  end

  def download
    respond_to do |format|
      format.html
      format.pdf do
        render  :pdf => "ops_works_visualization.pdf",
                :disposition => "attachment"
      end
    end
  end

end
