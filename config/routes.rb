Rails.application.routes.draw do
  root 'api/v1/urls#index'

  get ':shortened_body', to: 'api/v1/urls#show', as: 'shortened_body'

  defaults format: :json do
    namespace :api do
      namespace :v1 do

        resources :urls, only: [:index, :create]


        namespace :users do
          post 'login'
          post 'sign_up'
        end

      end
    end
  end
end
