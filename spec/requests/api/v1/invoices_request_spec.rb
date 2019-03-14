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
    invoice1 = create(:invoice)
    invoice = create(:invoice, created_at: '2012-03-27T14:56:04.000Z')

    get "/api/v1/invoices/find?created_at=#{invoice.created_at}"

    invoice_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_r["attributes"]["id"]).to eq(invoice.id)
  end
  it "find invoice  by updated_at" do
    invoice1 = create(:invoice)
    invoice = create(:invoice, updated_at: '2012-03-27T14:56:04.000Z')

    get "/api/v1/invoices/find?updated_at=#{invoice.updated_at}"

    invoice_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_r["attributes"]["id"]).to eq(invoice.id)
  end

  it "returns a collection of associated transactions" do
    invoice = create(:invoice)
    transaction1 = create(:transaction, invoice: invoice)
    transaction2 = create(:transaction, invoice: invoice)
    transaction3 = create(:transaction, invoice: invoice)


    get "/api/v1/invoices/#{invoice.id}/transactions"

    transactions = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transactions.count).to eq(3)

    transaction_ids = transactions.pluck('id')

    expect(transaction_ids).to include(transaction1.id.to_s)
    expect(transaction_ids).to include(transaction2.id.to_s)
    expect(transaction_ids).to include(transaction3.id.to_s)
  end

  it "returns a collection of associated invoice_items" do
    invoice = create(:invoice)

    invoice_item1 = create(:invoice_item, invoice: invoice)
    invoice_item2 = create(:invoice_item, invoice: invoice)
    invoice_item3 = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoices/#{invoice.id}/invoice_items"

    invoice_items = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_items.count).to eq(3)

    invoice_item_ids = invoice_items.pluck('id')

    expect(invoice_item_ids).to include(invoice_item1.id.to_s)
    expect(invoice_item_ids).to include(invoice_item2.id.to_s)
    expect(invoice_item_ids).to include(invoice_item3.id.to_s)
  end

  it "returns a collection of associated items" do
    invoice = create(:invoice)

    item1 = create(:item)
    item2 = create(:item)
    item3 = create(:item)

    invoice_item = create(:invoice_item, invoice: invoice, item: item1)
    invoice_item = create(:invoice_item, invoice: invoice, item: item2)
    invoice_item = create(:invoice_item, invoice: invoice, item: item3)

    get "/api/v1/invoices/#{invoice.id}/items"

    items = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(items.count).to eq(3)

    item_ids = items.pluck('id')

    expect(item_ids).to include(item1.id.to_s)
    expect(item_ids).to include(item2.id.to_s)
    expect(item_ids).to include(item3.id.to_s)
  end
end
