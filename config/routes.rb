OpsWorksVisualization::Application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :stacks
    end
  end

  root to: "api/v1/home#index"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
