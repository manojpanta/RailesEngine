class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    render json: RevenueSerializer.new(Merchant.revenue_by_date_across_all_merchant(params[:date].to_date))
  end
end
