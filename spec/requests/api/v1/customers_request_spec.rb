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
  it "find by customer first name" do
    customer = create(:customer, first_name:'me')

    get "/api/v1/customers/find?first_name=me"

    customer_r = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customer_r["attributes"]["first_name"]).to eq(customer.first_name)
  end
end
