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

    # merchant1 = Merchant.create(name: "Manoj")
    # merchant2 = Merchant.create(name: "Jerrel")
    item = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)


    # merchant1.items.create(name: "Twix")
    # merchant1.items.create(name: "M&Ms")
    # merchant2.items.create(name: "Failure")
    # merchant2.items.create(name: "Failure2")

    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(2)
    expect(items.first["name"]).to eq(item.name)
    expect(items.last["name"]).to eq(item2.name)
  end
end
