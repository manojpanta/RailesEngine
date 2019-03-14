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

      resources :merchants do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end
      namespace :invoices do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end
      resources :invoices, only: [:show] do
        resources :transactions, only: [:index]
        resources :invoice_items, only: [:index]
        resources :items, only: [:index]
        resources :customer, only: [:show]
        resources :merchant, only: [:show]
      end
      namespace :customers do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end

      namespace :transactions do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end

      namespace :invoice_items do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end


      namespace :items do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
      end

      resources :invoices
      resources :customers
      resources :transactions
      resources :items
      resources :invoice_items
    end
  end
end
