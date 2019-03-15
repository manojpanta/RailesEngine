class Customer < ApplicationRecord
  has_many :invoices
  has_many :merchants, through: :invoices
  has_many :transactions, through: :invoices

  def favorite_merchant
    merchants
    .select('merchants.*, count(transactions.*) as transactions_count')
    .joins(:transactions)
    .where(transactions: {result: 'success'})
    .order('transactions_count DESC')
    .group(:id)
    .limit(1)
    .first
  end
end
