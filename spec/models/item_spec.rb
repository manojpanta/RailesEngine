require 'rails_helper'
RSpec.describe Item, type: :model do
  describe 'relationships' do
    it {should belong_to :merchant }
    it {should have_many :invoice_items }
    it {should have_many :invoices }
    it {should belong_to :merchant }

    it 'returns most revenue items' do
      item1 = create(:item)
      item2 = create(:item)
      item3 = create(:item)

      invoice_item = create(:invoice_item, unit_price: 1000, quantity: 4, item: item1)
      invoice_item = create(:invoice_item, unit_price: 1000, quantity: 4, item: item1)
      invoice_item = create(:invoice_item, unit_price: 1000, quantity: 4, item: item1)
      # item 1 above generated 120.00 dollars
      invoice_item = create(:invoice_item, unit_price: 1000, quantity: 4, item: item2)
      invoice_item = create(:invoice_item, unit_price: 1000, quantity: 4, item: item2)
      # item 2 above generated 80.00 dollars
      invoice_item = create(:invoice_item, unit_price: 1000, quantity: 4, item: item3)
      # item 3 above generated 40.00 dollars

      items_returned = Item.most_revenue_items(2)
      expect(items_returned.length).to eq(2)
      expect(items_returned.first).to eq(item1)
      expect(items_returned.last).to eq(item2)
    end

    it "returns the top x item instances ranked by total number sold" do
      item1 = create(:item)
      item2 = create(:item)
      item3 = create(:item)

      invoice_item = create(:invoice_item, unit_price: 1000, quantity: 4, item: item1)
      invoice_item = create(:invoice_item, unit_price: 1000, quantity: 4, item: item1)
      invoice_item = create(:invoice_item, unit_price: 1000, quantity: 4, item: item1)
      # item 1 has sold 12
      invoice_item = create(:invoice_item, unit_price: 1000, quantity: 4, item: item2)
      invoice_item = create(:invoice_item, unit_price: 1000, quantity: 4, item: item2)
      # item 2 has sold 8
      invoice_item = create(:invoice_item, unit_price: 1000, quantity: 4, item: item3)
      # item 3 has sold 4

      items_returned = Item.most_items(2)

      expect(items_returned.length).to eq(2)
      expect(items_returned.first).to eq(item1)
      expect(items_returned.last).to eq(item2)
    end

    it "returns best day for item based on most sales" do
      item1 = create(:item)

      invoice = create(:invoice, created_at: "2012-03-27T14:56:04.000Z")

      invoice_item = create(:invoice_item, unit_price: 1000, quantity: 4, item: item1, invoice: invoice)
      invoice_item = create(:invoice_item, unit_price: 1000, quantity: 4, item: item1, invoice: invoice)
      invoice_item = create(:invoice_item, unit_price: 1000, quantity: 4, item: item1, invoice: invoice)
      # item 1 is sold 3 times on 2012-03-27T14:56:04.000Z
      invoice1 = create(:invoice, created_at: "2012-04-27T14:56:04.000Z")
      invoice_item = create(:invoice_item, unit_price: 1000, quantity: 4, item: item1, invoice: invoice1)
      invoice_item = create(:invoice_item, unit_price: 1000, quantity: 4, item: item1, invoice: invoice1)
      # item 1 is sold 2 times on 2012-04-27T14:56:04.000Z
      invoice2 = create(:invoice, created_at: "2012-05-27T14:56:04.000Z")
      invoice_item = create(:invoice_item, unit_price: 1000, quantity: 4, item: item1, invoice: invoice2)
      # item 1 is sold 1 time on 2012-04-27T14:56:04.000Z


      day_returned = item1.best_day

      expect(day_returned.created_at).to eq("2012-03-27T14:56:04.000Z")
    end
  end
end
