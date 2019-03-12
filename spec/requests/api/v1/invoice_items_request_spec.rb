require 'rails_helper'
describe "Invoice Items API" do
  it "returns a list of Invoice Items" do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items.json'

    invoice_items = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_items.count).to eq(3)
  end
end
