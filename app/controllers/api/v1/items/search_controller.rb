class Api::V1::Items::SearchController < ApplicationController
  def show
    if params[:unit_price]
      params[:unit_price] = params[:unit_price].delete('.')
      render json: ItemSerializer.new(Item.find_by(unit_price: params[:unit_price]))
    else
      render json: ItemSerializer.new(Item.order('id').find_by(search_params))
    end
  end

  def index
    if params[:unit_price]
      params[:unit_price] = params[:unit_price].delete('.')
      render json: ItemSerializer.new(Item.where(unit_price: params[:unit_price]))
    else
      render json: ItemSerializer.new(Item.where(search_params))
    end
  end


  private
  def search_params
    params.permit(:id, :name, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end

end
