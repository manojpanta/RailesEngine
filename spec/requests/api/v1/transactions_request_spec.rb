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
end
