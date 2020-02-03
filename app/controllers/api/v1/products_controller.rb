class Api::V1::ProductsController < ApplicationController
  skip_before_action :authenticate_request
  
  def index
    render json: Product.all
  end

  def search
    aggregation = params[:aggregation] || {}
    page = params[:page]
    search_command = Api::V1::Products::Search.call params[:text], aggregation, page

    if search_command.success?
      search_result = search_command.result
      products = search_command.result.results

      options = {}
      options[:meta] = Pagination.new(search_result).to_hash

      render json: ProductSerializer.new(products, options)
    else
      render json: { error: search_command.errors }, status: :internal_server_error
    end
  rescue Errors::StandardError => e
    render json: ErrorSerializer.new(e), status: e.status
  end
end