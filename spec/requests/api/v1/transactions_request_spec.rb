require 'rails_helper'
describe "Transaction API" do
  it "returns a list of transactions" do
    create_list(:transaction, 3)

    get '/api/v1/transactions.json'

    transactions = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transactions.count).to eq(3)
  end

  it "returns a transaction" do
    transaction = create(:transaction)

    get "/api/v1/transactions/#{transaction.id}"

    transaction_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transaction_r["attributes"]["id"]).to eq(transaction.id)
  end

  it "find transaction  by id" do
    transaction = create(:transaction)

    get "/api/v1/transactions/find?id=#{transaction.id}"

    transaction_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transaction_r["attributes"]["id"]).to eq(transaction.id)
  end

  it "find transaction  by credit_card_number" do
    transaction = create(:transaction, credit_card_number: 4654405418249632)

    get "/api/v1/transactions/find?credit_card_number=#{transaction.credit_card_number}"

    transaction_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transaction_r["attributes"]["id"]).to eq(transaction.id)
  end

  it "find transaction  by result" do
    transaction = create(:transaction, result: "success")

    get "/api/v1/transactions/find?result=#{transaction.result}"

    transaction_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transaction_r["attributes"]["id"]).to eq(transaction.id)
  end

  it "find transaction  by invoice_id" do
    invoice = create(:invoice)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/transactions/find?invoice_id=#{transaction.invoice_id}"

    transaction_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transaction_r["attributes"]["id"]).to eq(transaction.id)
  end

  it "find transaction  by credit_card_expiration_date" do
    transaction = create(:transaction,credit_card_expiration_date: 1233)

    get "/api/v1/transactions/find?credit_card_expiration_date=#{transaction.credit_card_expiration_date}"

    transaction_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transaction_r["attributes"]["id"]).to eq(transaction.id)
  end

  it "find transaction  by created_at" do
    transaction1 = create(:transaction)
    transaction = create(:transaction,created_at: "2012-03-27T14:56:04.000Z")

    get "/api/v1/transactions/find?created_at=#{transaction.created_at}"

    transaction_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transaction_r["attributes"]["id"]).to eq(transaction.id)
  end
  
  it "find transaction  by updated_at" do
    transaction1 = create(:transaction)
    transaction = create(:transaction,updated_at: "2012-03-27T14:56:04.000Z")

    get "/api/v1/transactions/find?updated_at=#{transaction.updated_at}"

    transaction_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(transaction_r["attributes"]["id"]).to eq(transaction.id)
  end

  it "returns the associated invoice" do
    invoice = create(:invoice)
    invoice2 = create(:invoice)
    transaction = create(:transaction, invoice: invoice)

    get "/api/v1/transactions/#{transaction.id}/invoice"

    invoice_returned = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_returned["attributes"]["id"]).to eq(invoice.id)
    expect(invoice_returned["attributes"]["id"]).to_not eq(invoice2.id)
  end
end
