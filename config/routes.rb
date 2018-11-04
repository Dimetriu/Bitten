Rails.application.routes.draw do

  defaults format: :json do
    namespace :api do
      namespace :v1 do

        namespace :users do
          post 'login'
          post 'sign_up'
        end

      end
    end
  end
end
