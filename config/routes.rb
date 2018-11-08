Rails.application.routes.draw do

  defaults format: :json do
    namespace :api do
      namespace :v1 do

        root 'urls#index'

        resources :urls, only: [:index, :create, :show]

        namespace :users do
          post 'login'
          post 'sign_up'
        end

      end
    end
  end
end
