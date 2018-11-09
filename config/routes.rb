Rails.application.routes.draw do
  root 'api/v1/urls#index'

  defaults format: :json do
    namespace :api do
      namespace :v1 do

        resources :urls, only: [:index, :create, :show]

        namespace :users do
          post 'login'
          post 'sign_up'
        end

      end
    end
  end
end
