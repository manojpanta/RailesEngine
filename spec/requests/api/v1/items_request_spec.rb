require 'rails_helper'
describe "Items API" do
  it "returns a list of Items" do
    create_list(:item, 3)

    get '/api/v1/items.json'

    items = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(items.count).to eq(3)
  end

  it "returns an Item" do
    item = create(:item)

    get "/api/v1/items/#{item.id}"

    item_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item_r["attributes"]["id"]).to eq(item.id)
  end

  it "find item  by id" do
    item = create(:item)

    get "/api/v1/items/find?id=#{item.id}"

    item_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item_r["attributes"]["id"]).to eq(item.id)
  end

  it "find item  by name" do
    item = create(:item, name: 'this')

    get "/api/v1/items/find?name=#{item.name}"

    item_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item_r["attributes"]["id"]).to eq(item.id)
  end

  it "find item  by description" do
    item = create(:item, description: "this is item which is not really an item")

    get "/api/v1/items/find?description=#{item.description}"

    item_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item_r["attributes"]["id"]).to eq(item.id)
  end

  it "find item  by unit_price" do
    item = create(:item, unit_price: 1234)

    get "/api/v1/items/find?unit_price=#{item.unit_price}"

    item_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item_r["attributes"]["id"]).to eq(item.id)
  end

  it "find item  by merchant id" do
    merchant = create(:merchant)

    item = create(:item, merchant: merchant)

    get "/api/v1/items/find?merchant_id=#{item.merchant_id}"

    item_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item_r["attributes"]["id"]).to eq(item.id)
  end

  it "find item  by created_at" do
    item1 = create(:item)
    item = create(:item, created_at: "2012-03-27T14:56:04.000Z")

    get "/api/v1/items/find?created_at=#{item.created_at}"

    item_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item_r["attributes"]["id"]).to eq(item.id)
  end
  
  it "find item  by updated_at" do
    item1 = create(:item)
    item = create(:item, updated_at: "2012-03-27T14:56:04.000Z")

    get "/api/v1/items/find?updated_at=#{item.updated_at}"

    item_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item_r["attributes"]["id"]).to eq(item.id)
  end

  it "returns a collection of associated invoice items" do
    item = create(:item)

    invoice_item1 = create(:invoice_item, item: item)
    invoice_item2 = create(:invoice_item, item: item)
    invoice_item3 = create(:invoice_item)

    get "/api/v1/items/#{item.id}/invoice_items"

    invoice_items = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_items.count).to eq(2)
    expect(invoice_items.first["attributes"]["id"]).to eq(invoice_item1.id)
    expect(invoice_items.last["attributes"]["id"]).to eq(invoice_item2.id)
  end

  it "returns the associated merchant" do
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    item = create(:item, merchant: merchant)

    get "/api/v1/items/#{item.id}/merchant"

    merchant_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant_r["attributes"]["id"]).to eq(merchant.id)
    expect(merchant_r["attributes"]["id"]).to_not eq(merchant2.id)
  end
end
