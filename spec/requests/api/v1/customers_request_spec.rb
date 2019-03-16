require 'rails_helper'
describe "Customers API" do
  it "returns a list of customers" do
    create_list(:customer, 3)

    get '/api/v1/customers.json'

    customers = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customers.count).to eq(3)
  end

  it "returns specific customer" do
    customer = create(:customer, first_name:'me')

    get "/api/v1/customers/#{customer.id}"

    customer_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customer_r["attributes"]["first_name"]).to eq('me')
  end

  it "find by customer id name" do
    customer = create(:customer)

    get "/api/v1/customers/find?id=#{customer.id}"

    customer_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customer_r["attributes"]["id"]).to eq(customer.id)
  end

  it "find by customer first name" do
    customer = create(:customer, first_name:'me')

    get "/api/v1/customers/find?first_name=me"

    customer_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customer_r["attributes"]["first_name"]).to eq(customer.first_name)
  end

  it "find by customer last name" do
    customer = create(:customer, last_name:'me')

    get "/api/v1/customers/find?last_name=me"

    customer_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customer_r["attributes"]["last_name"]).to eq(customer.last_name)
  end

  it "find by customer created at" do
    customer1 = create(:customer)
    customer = create(:customer, created_at: "2012-03-27T14:56:04.000Z" )

    get "/api/v1/customers/find?created_at=#{customer.created_at}"

    customer_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customer_r["attributes"]["id"]).to eq(customer.id)
  end

  it "find by customer updated at" do
    customer1 = create(:customer)
    customer = create(:customer, updated_at: "2012-03-27T14:56:04.000Z" )

    get "/api/v1/customers/find?updated_at=#{customer.updated_at}"


    customer_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customer_r["attributes"]["id"]).to eq(customer.id)
  end

  it "returns a collection of associated invoices" do
    customer = create(:customer)
    invoice1 = create(:invoice, customer: customer)
    invoice2 = create(:invoice, customer: customer)
    invoice3 = create(:invoice)

    get "/api/v1/customers/#{customer.id}/invoices"


    invoices_r = JSON.parse(response.body)["data"]

    invoice_ids = invoices_r.pluck('id')

    expect(response).to be_successful
    expect(invoice_ids).to include(invoice1.id.to_s)
    expect(invoice_ids).to include(invoice2.id.to_s)
    expect(invoice_ids).to_not include(invoice3.id.to_s)
  end

  it "returns a collection of associated transactions" do
    customer = create(:customer)

    invoice1 = create(:invoice, customer: customer)
    invoice2 = create(:invoice, customer: customer)

    transaction1 = create(:transaction, invoice: invoice1)
    transaction2 = create(:transaction, invoice: invoice1)
    transaction3 = create(:transaction, invoice: invoice2)
    transaction4 = create(:transaction)
    transaction5 = create(:transaction)

    get "/api/v1/customers/#{customer.id}/transactions"


    transactions = JSON.parse(response.body)["data"]
    transaction_ids = transactions.pluck('id')

    expect(response).to be_successful
    expect(transactions.count).to eq(3)
    expect(transaction_ids).to include(transaction1.id.to_s)
    expect(transaction_ids).to include(transaction2.id.to_s)
    expect(transaction_ids).to include(transaction3.id.to_s)
    expect(transaction_ids).to_not include(transaction4.id.to_s)
    expect(transaction_ids).to_not include(transaction5.id.to_s)
  end

  it "returns a merchant where the customer has conducted the most successful transactions" do
    customer = create(:customer)
    ##we have 3 merchants
    merchant = create(:merchant)
    merchant2 = create(:merchant)
    merchant3 = create(:merchant)
    ##lets create invoices for merchants with customer customer
    invoice1 = create(:invoice, customer: customer, merchant: merchant)
    invoice2 = create(:invoice, customer: customer, merchant: merchant)
    invoice3 = create(:invoice, customer: customer, merchant: merchant)
    invoice4 = create(:invoice, customer: customer, merchant: merchant2)
    invoice5 = create(:invoice, customer: customer, merchant: merchant3)
    ##we created 3 invoices for merchant , lets create 3 successful transactions for that merchant
    ## and merchant will be the favorite merchant for customer
    transaction1 = create(:transaction, invoice: invoice1, result: 'success' )
    transaction2 = create(:transaction, invoice: invoice2, result: 'success' )
    transaction3 = create(:transaction, invoice: invoice3, result: 'success' )
    transaction4 = create(:transaction, invoice: invoice4, result: 'success' )
    transaction5 = create(:transaction, invoice: invoice5, result: 'success' )

    get "/api/v1/customers/#{customer.id}/favorite_merchant"


    favorite_merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(favorite_merchant["attributes"]["id"]).to eq(merchant.id)
    expect(favorite_merchant["attributes"]["id"]).to_not eq(merchant2.id)
    expect(favorite_merchant["attributes"]["id"]).to_not eq(merchant2.id)
  end


  it "returns a merchant where the customer has conducted the most successful transactions" do
    customer = create(:customer)
    merchant = create(:merchant)
    allow(Customer).to receive(:favorite_merchant).with("#{customer.id}").and_return(merchant)

    get "/api/v1/customers/#{customer.id}/favorite_merchant"

    favorite_merchant = JSON.parse(response.body)["data"]
    
    expect(response).to be_successful
    expect(favorite_merchant["attributes"]["id"]).to eq(merchant.id)
  end
end
