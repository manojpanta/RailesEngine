require 'rails_helper'
describe "Invoices API" do
  it "returns a list of Invoices" do
    merchant = create(:merchant)
    customer = create(:customer)

    create_list(:invoice, 3)

    get '/api/v1/invoices.json'

    invoices = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoices.count).to eq(3)
  end
  it "returns a Invoice" do
    # merchant = create(:merchant)
    # customer = create(:customer)

    invoice = create(:invoice)

    get "/api/v1/invoices/#{invoice.id}"


    invoice_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_r["attributes"]["id"]).to eq(invoice.id)
  end
end
