class Api::V1::UrlsController < ApplicationController

  def index
    urls = Url.all

    render json: urls
  end

  def create
    command = Api::V1::Urls::ShortenUrl.call(current_user, params[:body])

    if command.success?
      render json: { url: command.result }
    else
      render json: { error: command.errors }, status: :unprocessable_entity
    end
  end

  def show

  end

end
