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
    customer = create(:customer, created_at: "2012-03-27 14:56:04 UTC" )

    get "/api/v1/customers/find?created_at=#{customer.created_at}"

    customer_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customer_r["attributes"]["created_at"]).to eq("2012-03-27T14:56:04.000Z")
  end

  it "find by customer updated at" do
    customer = create(:customer, updated_at: "2012-03-27 14:56:04 UTC" )

    get "/api/v1/customers/find?updated_at=#{customer.updated_at}"

    customer_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customer_r["attributes"]["updated_at"]).to eq("2012-03-27T14:56:04.000Z")
  end
end
