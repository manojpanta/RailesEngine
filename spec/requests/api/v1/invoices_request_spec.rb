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

  it "find invoice  by id" do
    invoice = create(:invoice)

    get "/api/v1/invoices/find?id=#{invoice.id}"

    invoice_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_r["attributes"]["id"]).to eq(invoice.id)
  end

  it "find invoice  by customer id" do
    customer = create(:customer)

    invoice = create(:invoice, customer: customer)

    get "/api/v1/invoices/find?customer_id=#{invoice.customer_id}"

    invoice_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_r["attributes"]["id"]).to eq(invoice.id)
  end

  it "find invoice  by merchant id" do
    merchant = create(:merchant)

    invoice = create(:invoice, merchant: merchant)

    get "/api/v1/invoices/find?merchant_id=#{invoice.merchant_id}"

    invoice_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_r["attributes"]["id"]).to eq(invoice.id)
  end

  it "find invoice  by status" do
    invoice = create(:invoice, status: 'pending')

    get "/api/v1/invoices/find?status=#{invoice.status}"

    invoice_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_r["attributes"]["id"]).to eq(invoice.id)
  end
  it "find invoice  by created_at" do
    invoice = create(:invoice, created_at: '2012-03-25 09:54:09 UTC')

    get "/api/v1/invoices/find?created_at=#{invoice.created_at}"

    invoice_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_r["attributes"]["id"]).to eq(invoice.id)
  end
  it "find invoice  by updated_at" do
    invoice = create(:invoice, updated_at: '2012-03-25 09:54:09 UTC')

    get "/api/v1/invoices/find?updated_at=#{invoice.updated_at}"

    invoice_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_r["attributes"]["id"]).to eq(invoice.id)
  end
end
