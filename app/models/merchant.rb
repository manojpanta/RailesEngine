class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

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

  def merchant_revenue
    invoices
    .select('sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: 'success'})[0]
  end

  def merchant_revenue_by_date(date)
    invoices
    .select('sum(invoice_items.unit_price * invoice_items.quantity) AS revenue')
    .joins(:invoice_items, :transactions)
    .where(invoices: { created_at: date.beginning_of_day..date.end_of_day})
    .where(transactions: {result: 'success'})[0]
  end


  def favorite_customer
    invoices
    .joins(:transactions, :customer)
    .select('customers.*, count(transactions.*) as transaction_count')
    .joins(:transactions)
    .where(transactions: {result: 'success'})
    .order('transaction_count DESC')
    .group('customers.id')
    .limit(1)
    .first
    ## Or WE could go following way
    customers ## since we already have relationship setup
    .select('customers.*, count(transactions.*) as transaction_count')
    .joins(:transactions)
    .where(transactions: {result: 'success'})
    .order('transaction_count DESC')
    .group('customers.id')
    .limit(1)
    .first
  end

  # def customers_with_pending_invoices
  #   Customer.find_by_sql ["SELECT customers.* FROM customers
  #                 FULL OUTER JOIN invoices ON customers.id = invoices.customer_id
  #                 FULL OUTER JOIN transactions ON invoices.id = transactions.invoice_id
  #                 WHERE invoices.merchant_id = #{id}
  #                 EXCEPT
  #                 SELECT customers.* FROM customers
  #                 FULL OUTER JOIN invoices ON customers.id = invoices.customer_id
  #                 FULL OUTER JOIN transactions ON invoices.id = transactions.invoice_id
  #                 WHERE invoices.merchant_id = #{id} and transactions.result = 'success';"]
  # end
end
