class Api::V1::Merchants::MostRevenueController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.merchants_ranked_by_most_revenue(params[:quantity]))
  end
end
