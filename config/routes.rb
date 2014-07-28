OpsWorksVisualization::Application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :stacks
      get "home/download" 
      get "home/index2"
    end
  end


  root to: "api/v1/home#index"
end
