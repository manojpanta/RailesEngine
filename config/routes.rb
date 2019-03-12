Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants do
        resources :items, only: [:index]
      end
      resources :customers
      resources :invoices
      resources :transactions
      resources :items
      resources :invoice_items
    end
  end
end
