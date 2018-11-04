class Api::V1::UsersController < ApplicationController
  # skip_before_action :authenticate_request!

  def login
    command = Api::V1::Auth::AuthenticateSubject.call(
      params[:email], params[:password]
      )

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  def sign_up
    command = Api::V1::Auth::RegisterSubject.call(
      params[:given_name],
      params[:family_name],
      params[:password],
      params[:password_confirmation]
    )

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unprocessable_entity
    end
  end
end
