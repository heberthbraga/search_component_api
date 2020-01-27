Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      post 'authenticate', to: 'authentication#authenticate'

      resources :products do
        collection do
          post 'search'
        end
      end

      resources :countries
    end
  end
end
