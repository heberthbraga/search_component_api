class ApplicationController < ActionController::API
  respond_to? :json

  before_action :set_default_response_format
  before_action :authenticate_request

  attr_reader :current_user


  private

  def authenticate_request
    @current_user = Authentication::Authorize.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end

  def set_default_response_format
    request.format = :json
  end
end
