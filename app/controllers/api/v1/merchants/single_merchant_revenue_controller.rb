class Api::V1::Merchants::SingleMerchantRevenueController< ApplicationController
  def show
    if params[:date]
      render json: RevenueForSingleMerchantSerializer.new(Merchant.find(params[:merchant_id]).merchant_revenue_by_date(params[:date].to_date))
    else
      render json: RevenueForSingleMerchantSerializer.new(Merchant.find(params[:merchant_id]).merchant_revenue)
    end
  end
end
