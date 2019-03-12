require 'rails_helper'
describe "Merchants API" do
  it "returns a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants.json'

    merchants = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchants.count).to eq(3)
  end

  it "returns a merchant" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    merchant_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant_r["attributes"]["id"]).to eq(merchant.id)
  end
  it "find merchant  by id" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant.id}"

    merchant_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant_r["attributes"]["id"]).to eq(merchant.id)
  end

  it "find merchant  by name" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"

    merchant_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant_r["attributes"]["id"]).to eq(merchant.id)
  end

  it "find merchant  by created_at" do
    merchant = create(:merchant, created_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

    merchant_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant_r["attributes"]["id"]).to eq(merchant.id)
  end
  it "find merchant  by updated_at" do
    merchant = create(:merchant, updated_at: "2012-03-27 14:53:59 UTC")

    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"

    merchant_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant_r["attributes"]["id"]).to eq(merchant.id)
  end

  it "returns all items for a merchant" do
    merchant = create(:merchant)

    item = create(:item, merchant: merchant, name: 'item1')
    item2 = create(:item, merchant: merchant, name: 'item2')

    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(items.count).to eq(2)
    expect(items.first["attributes"]["name"]).to eq("item1")
    expect(items.last["attributes"]["name"]).to eq("item2")
  end

  it "returns all invoices for a merchant" do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant: merchant, status: 'shipped')
    invoice2 = create(:invoice, merchant: merchant, status: 'not shipped')

    get "/api/v1/merchants/#{merchant.id}/invoices"

    invoices = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoices.count).to eq(2)

    expect(invoices.first["attributes"]["id"]).to eq(invoice.id)
    expect(invoices.last["attributes"]["id"]).to eq(invoice2.id)

    expect(invoices.first["attributes"]["status"]).to eq('shipped')
    expect(invoices.last["attributes"]["status"]).to eq('not shipped')
  end
end
