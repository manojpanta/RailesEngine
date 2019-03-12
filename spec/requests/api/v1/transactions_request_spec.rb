require 'rails_helper'
describe "Transaction API" do
  it "returns a list of transaction" do
    create_list(:transaction, 3)

    get '/api/v1/transactions.json'

    transactions = JSON.parse(response.body)

    expect(response).to be_successful
    expect(transactions.count).to eq(3)
  end
end
