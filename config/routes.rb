OpsWorksVisualization::Application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :stacks
      get "visualizations/all" => "visualizations#all"
    end
  end

  root to: "api/v1/visualizations#all"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
