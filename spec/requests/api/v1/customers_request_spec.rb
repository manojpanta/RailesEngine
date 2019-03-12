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

    customer = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(customer["attributes"]["first_name"]).to eq('me')
  end
end
