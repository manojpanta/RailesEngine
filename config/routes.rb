Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: 'search#show'
      end

      resources :merchants do
        resources :items, only: [:index]
        resources :invoices, only: [:index]
      end
      namespace :customers do
        get 'find', to: 'search#show'
      end

      namespace :transactions do
        get 'find', to: 'search#show'
      end

      namespace :invoice_items do
        get 'find', to: 'search#show'
      end

      namespace :invoices do
        get 'find', to: 'search#show'
      end

      namespace :items do
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
