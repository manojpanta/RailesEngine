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

  it "find invoice items by item id " do
    item = create(:item)

    invoice_item = create(:invoice_item, item_id: item.id )

    get "/api/v1/invoice_items/find?item_id=#{invoice_item.item_id}"

    invoice_item_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_item_r["attributes"]["id"]).to eq(invoice_item.id)
  end

  it "find invoice items by invoice id " do
    invoice = create(:invoice)

    invoice_item = create(:invoice_item, invoice_id: invoice.id )

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_item.invoice_id}"

    invoice_item_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_item_r["attributes"]["id"]).to eq(invoice_item.id)
  end

  it "find invoice items by unit_price " do
    invoice_item = create(:invoice_item, unit_price: 1234)

    get "/api/v1/invoice_items/find?unit_price=1234"

    invoice_item_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_item_r["attributes"]["id"]).to eq(invoice_item.id)
  end

  it "find invoice items by quantity" do
    invoice_item = create(:invoice_item, quantity: 2)

    get "/api/v1/invoice_items/find?quantity=2"

    invoice_item_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_item_r["attributes"]["id"]).to eq(invoice_item.id)
  end

  it "find invoice items by created_at" do
    invoice_item1 = create(:invoice_item)
    invoice_item = create(:invoice_item, created_at: "2012-03-27T14:56:04.000Z")

    get "/api/v1/invoice_items/find?created_at=#{invoice_item.created_at}"

    invoice_item_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_item_r["attributes"]["id"]).to eq(invoice_item.id)
  end

  it "find invoice items by updated_at" do
    invoice_item1 = create(:invoice_item)
    invoice_item = create(:invoice_item, updated_at: "2012-03-27T14:56:04.000Z")

    get "/api/v1/invoice_items/find?updated_at=#{invoice_item.updated_at}"

    invoice_item_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_item_r["attributes"]["id"]).to eq(invoice_item.id)
  end

  it " returns the associated invoice" do
    invoice = create(:invoice)
    invoice2 = create(:invoice)
    invoice_item = create(:invoice_item, invoice: invoice)

    get "/api/v1/invoice_items/#{invoice_item.id}/invoice"

    invoice_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_r["attributes"]["id"]).to eq(invoice.id)
    expect(invoice_r["attributes"]["id"]).to_not eq(invoice2.id)
  end

  it "returns the associated item" do
    item = create(:item)
    item2 = create(:item)
    invoice_item = create(:invoice_item, item: item)

    get "/api/v1/invoice_items/#{invoice_item.id}/item"

    item_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item_r["attributes"]["id"]).to eq(item.id)
    expect(item_r["attributes"]["id"]).to_not eq(item2.id)
  end
end
