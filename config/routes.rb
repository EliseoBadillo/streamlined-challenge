Rails.application.routes.draw do
  resources :merchants, :cc_transactions, :ach_transactions
  scope '/audits' do
    get '/transactions', to: 'audits#transactions'
    get '/payouts', to: 'audits#payouts'
    get '/payout/:id', to: 'audits#payout'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
