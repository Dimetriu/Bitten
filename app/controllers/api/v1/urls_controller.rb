class Api::V1::UrlsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    # urls = current_user.urls.select(:body, :shortened_body)
    urls = Url.select(:body, :shortened_body)

    render json: urls
  end

  def create
    command = Api::V1::Urls::Build.call(current_user, params[:body])

    if command.success?
      render json: { url: command.result, status: :created }
    else
      render json: { error: command.errors , status: :unprocessable_entity }
    end
  end

  def show
    url = Url.find(params[:shortened_body])
    command = Api::V1::Urls::BuildVisit.call(url, request.remote_ip)

    if command.success?
      logger.info command.result
    else
      logger.warn command.errors
    end

    redirect_to url.body
  end

  private
    def record_not_found
      logger.warn I18n.t('record_not_found', reason: params[:shortened_body])
      render json: { shortened_body: params[:shortened_body] , status: 404 }
    end

end
