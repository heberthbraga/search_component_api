class Api::V1::ProductsController < ApplicationController
  skip_before_action :authenticate_request
  
  def index
    render json: Product.all
  end

  def search
    aggregation = params[:aggregation] || {}
    search_command = Api::V1::Products::Search.call params[:text], aggregation

    if search_command.success?
      products = search_command.result.results

      render json: products
    else
      render json: { error: search_command.errors }, status: :internal_server_error
    end
  rescue Errors::StandardError => e
    render json: ErrorSerializer.new(e), status: e.status
  end
end