class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    render json: MerchantSerializer.new(Merchant.merchants_ranked_by_most_items_sold(params[:quantity]))
  end
end
