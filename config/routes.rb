OpsWorksVisualization::Application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :stacks
    end
  end

  root to: "api/v1/home#index"
end
