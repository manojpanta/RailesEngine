Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end
      namespace :customers do
        get 'find', to: 'search#show'
      end

      namespace :invoice_items do
        get 'find', to: 'search#show'
      end
      resources :customers
      resources :invoices
      resources :transactions
      resources :items
      resources :invoice_items
    end
  end
end
