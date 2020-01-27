class Api::V1::CountriesController < ApplicationController
  skip_before_action :authenticate_request
  
  def index
    render json: Country.all
  end
end