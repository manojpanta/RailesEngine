class Api::V1::Merchants::SingleMerchantRevenueController< ApplicationController
  def show
    render json: RevenueForSingleMerchantSerializer.new(Merchant.find(params[:merchant_id]).merchant_revenue)
  end
end
