require 'rails_helper'
describe "Items API" do
  it "returns a list of Items" do
    create_list(:item, 3)

    get '/api/v1/items.json'

    items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(items.count).to eq(3)
  end
end
