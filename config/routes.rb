Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants
      resources :customers
      resources :invoices
      resources :transactions
      resources :items
      resources :invoice_items
    end
  end
end
