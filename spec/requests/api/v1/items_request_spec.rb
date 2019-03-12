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
end
