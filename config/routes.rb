Rails.application.routes.draw do

  defaults format: :json do
    namespace :api do
      namespace :v1 do

        namespace :users do
          post 'login', to: 'authentication#login'
          post 'sign_up', to: 'authentication#sign_up'
        end

      end
    end
  end
end
