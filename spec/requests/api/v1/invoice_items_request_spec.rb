require 'rails_helper'
describe "Invoice Items API" do
  it "returns a list of Invoice Items" do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items.json'

    invoice_items = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_items.count).to eq(3)
  end
  it "returns a  Invoice Item" do
    invoice_item = create(:invoice_item)

    get "/api/v1/invoice_items/#{invoice_item.id}"

    invoice_item_returned = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_item_returned["attributes"]["id"]).to eq(invoice_item.id)
  end

  it "find invoice items by id " do
    invoice_item = create(:invoice_item )

    get "/api/v1/invoice_items/find?id=#{invoice_item.id}"

    invoice_item_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_item_r["attributes"]["id"]).to eq(invoice_item.id)
  end
end
