Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'most_revenue', to: 'most_revenue#index'
        get 'most_items', to: 'most_items#index'
        get 'revenue', to: 'revenue#show'
      end
      resources :merchants, only: [:show, :index] do
        get 'items', to: 'merchants/items#index'
        get 'invoices', to: 'merchants/invoices#index'
        get 'revenue', to: 'merchants/single_merchant_revenue#show'
        get 'favorite_customer', to: 'merchants/favorite_customer#show'
      end
      namespace :invoices do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end

      resources :invoices, only: [:show, :index] do
        get 'items', to: 'invoices/items#index'
        get 'transactions', to: 'invoices/transactions#index'
        get 'invoice_items', to: 'invoices/invoice_items#index'
        get 'customer', to: 'invoices/customer#show'
        get 'merchant', to: 'invoices/merchant#show'
      end

      namespace :invoice_items do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end

      resources :invoice_items, only: [:show, :index] do
        get 'invoice', to: 'invoice_items/invoice#show'
        get 'item', to: 'invoice_items/item#show'
      end

      namespace :items do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end

      resources :items, only: [:show, :index] do
        get 'invoice_items', to: 'items/invoice_items#index'
        get 'merchant', to: 'items/merchant#show'
      end

      namespace :transactions do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end

      resources :transactions, only: [:show, :index] do
        get 'invoice', to: 'transactions/invoice#show'
      end

      namespace :customers do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end
      resources :customers, only: [:show, :index] do
        get 'invoices', to: 'customers/invoices#index'
        get 'transactions', to: 'customers/transactions#index'
      end
    end
  end
end
