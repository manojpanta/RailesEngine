require 'rails_helper'
describe "Merchants API" do
  it "returns a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants.json'

    merchants = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchants.count).to eq(3)
  end

  it "returns a merchant" do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}"

    merchant_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant_r["attributes"]["id"]).to eq(merchant.id)
  end
  it "find merchant  by id" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant.id}"

    merchant_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant_r["attributes"]["id"]).to eq(merchant.id)
  end

  it "find merchant  by name" do
    merchant = create(:merchant)

    get "/api/v1/merchants/find?name=#{merchant.name}"

    merchant_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant_r["attributes"]["id"]).to eq(merchant.id)
  end

  it "find merchant  by created_at" do
    merchant1 = create(:merchant)
    merchant = create(:merchant, created_at: "2012-03-27T14:56:04.000Z")

    get "/api/v1/merchants/find?created_at=#{merchant.created_at}"

    merchant_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant_r["attributes"]["id"]).to eq(merchant.id)
  end
  it "find merchant  by updated_at" do
    merchant1 = create(:merchant)
    merchant = create(:merchant, updated_at: "2012-03-27T14:56:04.000Z")

    get "/api/v1/merchants/find?updated_at=#{merchant.updated_at}"

    merchant_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchant_r["attributes"]["id"]).to eq(merchant.id)
  end

  it "returns all items for a merchant" do
    merchant = create(:merchant)

    item = create(:item, merchant: merchant, name: 'item1')
    item2 = create(:item, merchant: merchant, name: 'item2')

    get "/api/v1/merchants/#{merchant.id}/items"

    items = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(items.count).to eq(2)
    expect(items.first["attributes"]["name"]).to eq("item1")
    expect(items.last["attributes"]["name"]).to eq("item2")
  end

  it "returns all invoices for a merchant" do
    merchant = create(:merchant)
    invoice = create(:invoice, merchant: merchant, status: 'shipped')
    invoice2 = create(:invoice, merchant: merchant, status: 'not shipped')

    get "/api/v1/merchants/#{merchant.id}/invoices"

    invoices = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoices.count).to eq(2)

    expect(invoices.first["attributes"]["id"]).to eq(invoice.id)
    expect(invoices.last["attributes"]["id"]).to eq(invoice2.id)

    expect(invoices.first["attributes"]["status"]).to eq('shipped')
    expect(invoices.last["attributes"]["status"]).to eq('not shipped')
  end

  it "can return merchants ranked based on most revenue" do
    ##create customer
    customer = create(:customer)
    ## create merchants
    merchant = create(:merchant)
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    ##create items for that merchant
    item = create(:item, merchant: merchant)
    item1 = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)
    ##create items for that merchant1
    item3 = create(:item, merchant: merchant1)
    item4 = create(:item, merchant: merchant1)
    item5 = create(:item, merchant: merchant1)
    ##create items for that merchant2
    item6 = create(:item, merchant: merchant2)
    item7 = create(:item, merchant: merchant2)
    item8 = create(:item, merchant: merchant2)
    ##create items for that merchant3
    item9 = create(:item, merchant: merchant3)
    item10 = create(:item, merchant: merchant3)
    item11 = create(:item, merchant: merchant3)
    ##create invoices for merchant
    invoice1= create(:invoice, merchant: merchant, customer: customer)
    invoice_item1 = create(:invoice_item, invoice: invoice1, item: item, unit_price: 1500, quantity: 10)
    invoice_item2 = create(:invoice_item, invoice: invoice1, item: item1, unit_price: 1500, quantity: 10)
    invoice_item3 = create(:invoice_item, invoice: invoice1, item: item2, unit_price: 1500, quantity: 10)
    ##create invoices for merchant1
    invoice2 = create(:invoice, merchant: merchant1, customer: customer)
    invoice_item4 = create(:invoice_item, invoice: invoice2, item: item3, unit_price: 1500, quantity: 10)
    invoice_item5 = create(:invoice_item, invoice: invoice2, item: item4, unit_price: 1500, quantity: 1)
    invoice_item6 = create(:invoice_item, invoice: invoice2, item: item5, unit_price: 1500, quantity: 9)

    ##create invoices for merchant2
    invoice3 = create(:invoice, merchant: merchant2, customer: customer)
    invoice_item7 = create(:invoice_item, invoice: invoice3, item: item6, unit_price: 1500, quantity: 4)
    invoice_item8 = create(:invoice_item, invoice: invoice3, item: item7, unit_price: 1500, quantity: 3)
    invoice_item9 = create(:invoice_item, invoice: invoice3, item: item8, unit_price: 1500, quantity: 3)

    ##create invoices for merchant3
    invoice4 = create(:invoice, merchant: merchant3, customer: customer)
    invoice_item10 = create(:invoice_item, invoice: invoice4, item: item9, unit_price: 1500, quantity: 1)
    invoice_item11 = create(:invoice_item, invoice: invoice4, item: item10, unit_price: 1500, quantity: 3)
    invoice_item12 = create(:invoice_item, invoice: invoice4, item: item11, unit_price: 1500, quantity: 3)

    ##create succeeful transaction for all the invoices
    transaction = create(:transaction, invoice: invoice1, result: "success")
    transaction = create(:transaction, invoice: invoice2, result: "success")
    transaction = create(:transaction, invoice: invoice3, result: "success")

    ## We should expect merchant on top of ranking and merchant2 on bottom.
    ##because they are selling items with same unit price but quantities sold are 30, 20, 10 for merchant, merchant1 and merchant2 respectively.

    get "/api/v1/merchants/most_revenue?quantity=3"

    merchants = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchants.count).to eq(3)

    expect(merchants.first["attributes"]["id"]).to eq(merchant.id)
    expect(merchants[1]["attributes"]["id"]).to eq(merchant1.id)
    expect(merchants.last["attributes"]["id"]).to eq(merchant2.id)
  end
  it "can return merchants ranked based on most items sold" do
    ##create customer
    customer = create(:customer)
    ## create merchants
    merchant = create(:merchant)
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    ##create items for that merchant
    item = create(:item, merchant: merchant)
    item1 = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)
    ##create items for that merchant1
    item3 = create(:item, merchant: merchant1)
    item4 = create(:item, merchant: merchant1)
    item5 = create(:item, merchant: merchant1)
    ##create items for that merchant2
    item6 = create(:item, merchant: merchant2)
    item7 = create(:item, merchant: merchant2)
    item8 = create(:item, merchant: merchant2)
    ##create items for that merchant3
    item9 = create(:item, merchant: merchant3)
    item10 = create(:item, merchant: merchant3)
    item11 = create(:item, merchant: merchant3)
    ##create invoices for merchant
    invoice1= create(:invoice, merchant: merchant, customer: customer)
    invoice_item1 = create(:invoice_item, invoice: invoice1, item: item, unit_price: 1500, quantity: 10)
    invoice_item2 = create(:invoice_item, invoice: invoice1, item: item1, unit_price: 1500, quantity: 10)
    invoice_item3 = create(:invoice_item, invoice: invoice1, item: item2, unit_price: 1500, quantity: 10)
    ##create invoices for merchant1
    invoice2 = create(:invoice, merchant: merchant1, customer: customer)
    invoice_item4 = create(:invoice_item, invoice: invoice2, item: item3, unit_price: 1500, quantity: 10)
    invoice_item5 = create(:invoice_item, invoice: invoice2, item: item4, unit_price: 1500, quantity: 1)
    invoice_item6 = create(:invoice_item, invoice: invoice2, item: item5, unit_price: 1500, quantity: 9)

    ##create invoices for merchant2
    invoice3 = create(:invoice, merchant: merchant2, customer: customer)
    invoice_item7 = create(:invoice_item, invoice: invoice3, item: item6, unit_price: 1500, quantity: 4)
    invoice_item8 = create(:invoice_item, invoice: invoice3, item: item7, unit_price: 1500, quantity: 3)
    invoice_item9 = create(:invoice_item, invoice: invoice3, item: item8, unit_price: 1500, quantity: 3)

    ##create invoices for merchant3
    invoice4 = create(:invoice, merchant: merchant3, customer: customer)
    invoice_item10 = create(:invoice_item, invoice: invoice4, item: item9, unit_price: 1500, quantity: 1)
    invoice_item11 = create(:invoice_item, invoice: invoice4, item: item10, unit_price: 1500, quantity: 3)
    invoice_item12 = create(:invoice_item, invoice: invoice4, item: item11, unit_price: 1500, quantity: 3)

    ##create succeeful transaction for all the invoices
    transaction = create(:transaction, invoice: invoice1, result: "success")
    transaction = create(:transaction, invoice: invoice2, result: "success")
    transaction = create(:transaction, invoice: invoice3, result: "success")

    ## We should expect merchant on top of ranking and merchant2 on bottom.
    ##because they are selling items with same unit price but quantities sold are 30, 20, 10, 7 for merchant, merchant1, merchant2, and merchant3 respectively.

    get "/api/v1/merchants/most_items?quantity=3"

    merchants = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(merchants.count).to eq(3)

    expect(merchants.first["attributes"]["id"]).to eq(merchant.id)
    expect(merchants[1]["attributes"]["id"]).to eq(merchant1.id)
    expect(merchants.last["attributes"]["id"]).to eq(merchant2.id)
  end
  it "can return revenue by date across all merchants" do
    ##create customer
    customer = create(:customer)
    ## create merchants
    merchant = create(:merchant)
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    ##create items for that merchant
    item = create(:item, merchant: merchant)
    item1 = create(:item, merchant: merchant)
    item2 = create(:item, merchant: merchant)
    ##create items for that merchant1
    item3 = create(:item, merchant: merchant1)
    item4 = create(:item, merchant: merchant1)
    item5 = create(:item, merchant: merchant1)
    ##create items for that merchant2
    item6 = create(:item, merchant: merchant2)
    item7 = create(:item, merchant: merchant2)
    item8 = create(:item, merchant: merchant2)
    ##create items for that merchant3
    item9 = create(:item, merchant: merchant3)
    item10 = create(:item, merchant: merchant3)
    item11 = create(:item, merchant: merchant3)
    ##create invoices for merchant
    invoice1= create(:invoice, merchant: merchant, customer: customer, created_at: '2012-04-25 09:54:09 UTC')
    invoice_item1 = create(:invoice_item, invoice: invoice1, item: item, unit_price: 1500, quantity: 10)
    invoice_item2 = create(:invoice_item, invoice: invoice1, item: item1, unit_price: 1500, quantity: 10)
    invoice_item3 = create(:invoice_item, invoice: invoice1, item: item2, unit_price: 1500, quantity: 10)
    ##create invoices for merchant1
    invoice2 = create(:invoice, merchant: merchant1, customer: customer, created_at: '2012-04-25 09:54:09 UTC')
    invoice_item4 = create(:invoice_item, invoice: invoice2, item: item3, unit_price: 1500, quantity: 10)
    invoice_item5 = create(:invoice_item, invoice: invoice2, item: item4, unit_price: 1500, quantity: 1)
    invoice_item6 = create(:invoice_item, invoice: invoice2, item: item5, unit_price: 1500, quantity: 9)

    ##create invoices for merchant2
    invoice3 = create(:invoice, merchant: merchant2, customer: customer)
    invoice_item7 = create(:invoice_item, invoice: invoice3, item: item6, unit_price: 1500, quantity: 4)
    invoice_item8 = create(:invoice_item, invoice: invoice3, item: item7, unit_price: 1500, quantity: 3)
    invoice_item9 = create(:invoice_item, invoice: invoice3, item: item8, unit_price: 1500, quantity: 3)

    ##create invoices for merchant3
    invoice4 = create(:invoice, merchant: merchant3, customer: customer)
    invoice_item10 = create(:invoice_item, invoice: invoice4, item: item9, unit_price: 1500, quantity: 1)
    invoice_item11 = create(:invoice_item, invoice: invoice4, item: item10, unit_price: 1500, quantity: 3)
    invoice_item12 = create(:invoice_item, invoice: invoice4, item: item11, unit_price: 1500, quantity: 3)

    ##create succeeful transaction for all the invoices
    transaction = create(:transaction, invoice: invoice1, result: "success")
    transaction = create(:transaction, invoice: invoice2, result: "success")
    transaction = create(:transaction, invoice: invoice3, result: "success")

    ## We should expect merchant on top of ranking and merchant2 on bottom.
    ##because they are selling items with same unit price but quantities sold are 30, 20, 10, 7 for merchant, merchant1, merchant2, and merchant3 respectively.

    get "/api/v1/merchants/revenue?date=#{invoice1.created_at}"

    revenue = JSON.parse(response.body)["data"]
    expected_revenue = (invoice_item1.unit_price * invoice_item1.quantity +
                       invoice_item2.unit_price * invoice_item2.quantity +
                       invoice_item3.unit_price * invoice_item3.quantity +
                       invoice_item4.unit_price * invoice_item4.quantity +
                       invoice_item5.unit_price * invoice_item5.quantity +
                       invoice_item6.unit_price * invoice_item6.quantity)/100


    expect(response).to be_successful
    expect(revenue["attributes"]["total_revenue"].to_i,).to eq(expected_revenue.to_i)
  end
end
