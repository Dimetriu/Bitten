class Api::V1::UrlsController < ApplicationController

  def index
    urls = Url.select(:body, :shortened_body)

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
    url = Url.find(params[:shortened_body])

    render json: url
  end

end
