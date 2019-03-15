class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items

  def self.most_revenue_items(quantity)
    select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .joins(:invoice_items)
    .order('revenue DESC')
    .group(:id)
    .limit(quantity)
  end

  def self.most_items(quantity)
    select('items.*, sum(invoice_items.quantity) as quantity_sold')
    .joins(:invoice_items)
    .order('quantity_sold DESC')
    .group(:id)
    .limit(quantity)
  end

  def best_day
    invoices
    .select('invoices.*, sum(invoice_items.quantity) as sales_count')
    .order('sales_count DESC, invoices.created_at DESC')
    .group(:id)
    .first
  end
end
