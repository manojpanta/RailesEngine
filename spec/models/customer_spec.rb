require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationship' do
  end

  describe 'methods ' do
    it "returns a merchant where the customer has conducted the most successful transactions" do
      customer = create(:customer)
      ##we have 3 merchants
      merchant = create(:merchant)
      merchant2 = create(:merchant)
      merchant3 = create(:merchant)
      ##lets create invoices for merchants with customer customer
      invoice1 = create(:invoice, customer: customer, merchant: merchant)
      invoice2 = create(:invoice, customer: customer, merchant: merchant)
      invoice3 = create(:invoice, customer: customer, merchant: merchant)
      invoice4 = create(:invoice, customer: customer, merchant: merchant2)
      invoice5 = create(:invoice, customer: customer, merchant: merchant3)
      ##we created 3 invoices for merchant , lets create 3 successful transactions for that merchant
      ## and merchant will be the favorite merchant for customer
      transaction1 = create(:transaction, invoice: invoice1, result: 'success' )
      transaction2 = create(:transaction, invoice: invoice2, result: 'success' )
      transaction3 = create(:transaction, invoice: invoice3, result: 'success' )
      transaction4 = create(:transaction, invoice: invoice4, result: 'success' )
      transaction5 = create(:transaction, invoice: invoice5, result: 'success' )

      favorite_merchant = Customer.favorite_merchant(customer.id)

      expect(favorite_merchant).to eq(merchant)
    end
  end
end
