class Api::V1::UrlsController < ApplicationController

  def index
    user = User.first

    render json: { user }
  end
end
