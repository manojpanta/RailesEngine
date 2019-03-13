class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.merchants_ranked_by_most_revenue(quantity)
    select('merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue')
    .joins(invoices: [:invoice_items,  :transactions])
    .where(transactions: {result: 'success'})
    .order('revenue DESC')
    .group(:id)
    .limit(quantity)
  end

  def self.merchants_ranked_by_most_items_sold(quantity)
    select('merchants.*, sum(invoice_items.quantity) as items_sold')
    .joins(invoices: [:invoice_items, :transactions])
    .where(transactions: {result: 'success'})
    .order('items_sold DESC')
    .group(:id)
    .limit(quantity)
  end

  def self.revenue_by_date_across_all_merchant(date)
      select("SUM(invoice_items.unit_price * invoice_items.quantity) AS revenue")
      .joins(invoices: [:invoice_items, :transactions])
      .where(transactions: { result: 'success' })
      .where(invoices: { created_at: date.beginning_of_day..date.end_of_day})[0]
  end
end
