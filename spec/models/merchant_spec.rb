require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe 'relationships' do
    it {should have_many :items}
    it {should have_many :invoices}
  end

  describe 'method merchants ranked by most revenue method ' do
    it 'returns merchants ranked by revenue' do
      ##create customer
      customer = create(:customer)
      ## create merchants
      merchant = create(:merchant)
      merchant1 = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      ##create items for that merchant
      item = create(:item, merchant: merchant)
      item1 = create(:item, merchant: merchant)
      item2 = create(:item, merchant: merchant)
      ##create items for that merchant1
      item3 = create(:item, merchant: merchant1)
      item4 = create(:item, merchant: merchant1)
      item5 = create(:item, merchant: merchant1)
      ##create items for that merchant2
      item6 = create(:item, merchant: merchant2)
      item7 = create(:item, merchant: merchant2)
      item8 = create(:item, merchant: merchant2)
      ##create items for that merchant3
      item9 = create(:item, merchant: merchant3)
      item10 = create(:item, merchant: merchant3)
      item11 = create(:item, merchant: merchant3)
      ##create invoices for merchant
      invoice1= create(:invoice, merchant: merchant, customer: customer)
      invoice_item1 = create(:invoice_item, invoice: invoice1, item: item, unit_price: 1500, quantity: 10)
      invoice_item2 = create(:invoice_item, invoice: invoice1, item: item1, unit_price: 1500, quantity: 10)
      invoice_item3 = create(:invoice_item, invoice: invoice1, item: item2, unit_price: 1500, quantity: 10)
      ##create invoices for merchant1
      invoice2 = create(:invoice, merchant: merchant1, customer: customer)
      invoice_item4 = create(:invoice_item, invoice: invoice2, item: item3, unit_price: 1500, quantity: 10)
      invoice_item5 = create(:invoice_item, invoice: invoice2, item: item4, unit_price: 1500, quantity: 1)
      invoice_item6 = create(:invoice_item, invoice: invoice2, item: item5, unit_price: 1500, quantity: 9)

      ##create invoices for merchant2
      invoice3 = create(:invoice, merchant: merchant2, customer: customer)
      invoice_item7 = create(:invoice_item, invoice: invoice3, item: item6, unit_price: 1500, quantity: 4)
      invoice_item8 = create(:invoice_item, invoice: invoice3, item: item7, unit_price: 1500, quantity: 3)
      invoice_item9 = create(:invoice_item, invoice: invoice3, item: item8, unit_price: 1500, quantity: 3)

      ##create invoices for merchant3
      invoice4 = create(:invoice, merchant: merchant3, customer: customer)
      invoice_item10 = create(:invoice_item, invoice: invoice4, item: item9, unit_price: 1500, quantity: 1)
      invoice_item11 = create(:invoice_item, invoice: invoice4, item: item10, unit_price: 1500, quantity: 3)
      invoice_item12 = create(:invoice_item, invoice: invoice4, item: item11, unit_price: 1500, quantity: 3)

      ##create succeeful transaction for all the invoices
      transaction = create(:transaction, invoice: invoice1, result: "success")
      transaction = create(:transaction, invoice: invoice2, result: "success")
      transaction = create(:transaction, invoice: invoice3, result: "success")


      merchants = Merchant.merchants_ranked_by_most_revenue(3)

      expect(merchants.length).to eq(3)
      expect(merchants.first).to eq(merchant)
      expect(merchants.second).to eq(merchant1)
      expect(merchants.last).to eq(merchant2)
    end
  end
end
