class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices
  has_many :merchants, through: :invoices

  def self.favorite_merchant(id)
    Merchant
    .select('merchants.*, count(transactions.*) as transactions_count')
    .joins(:transactions, :customers)
    .where(transactions: {result: 'success'})
    .where(customers: {id: id})
    .order('transactions_count DESC')
    .group(:id)
    .limit(1)
    .first
  end
end
