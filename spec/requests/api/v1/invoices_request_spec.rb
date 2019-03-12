require 'rails_helper'
describe "Invoices API" do
  it "returns a list of Invoices" do
    merchant = create(:merchant)
    customer = create(:customer)

    create_list(:invoice, 3)

    get '/api/v1/invoices.json'

    invoices = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoices.count).to eq(3)
  end
end
