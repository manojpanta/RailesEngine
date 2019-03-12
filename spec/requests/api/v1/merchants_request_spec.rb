require 'rails_helper'
describe "Merchants API" do
  it "returns a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants.json'

    merchants = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchants.count).to eq(3)
  end

  it "returns all items for a merchant" do
    merchant = create(:merchant)

    item = create(:item, merchant: merchant, name: 'item1')
    item2 = create(:item, merchant: merchant, name: 'item2')

    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(2)
    expect(items.first["name"]).to eq("item1")
    expect(items.last["name"]).to eq("item2")
  end

  it "returns all invoices for a merchant" do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant: merchant, status: 'shipped')
    invoice2 = create(:invoice, merchant: merchant, status: 'not shipped')

    get "/api/v1/merchants/#{merchant.id}/invoices"

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices.count).to eq(2)

    expect(invoices.first["id"]).to eq(invoice.id)
    expect(invoices.last["id"]).to eq(invoice2.id)

    expect(invoices.first["status"]).to eq('shipped')
    expect(invoices.last["status"]).to eq('not shipped')
  end
end
