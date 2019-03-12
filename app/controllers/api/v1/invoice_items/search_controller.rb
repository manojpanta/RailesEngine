class Api::V1::InvoiceItems::SearchController < ApplicationController
  def show
    if params[:unit_price]
      params[:unit_price] = params[:unit_price].delete('.')
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(unit_price: params[:unit_price]))
    else
      render json: InvoiceItemSerializer.new(InvoiceItem.find_by(search_params))
    end
  end


  private

  def search_params
    params.permit(:id, :item_id, :invoice_id, :quantity, :unit_price, :created_at, :updated_at)
  end

end
