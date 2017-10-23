Rails.application.routes.draw do
  devise_for :users
  concern :active_scaffold_association, ActiveScaffold::Routing::Association.new
  concern :active_scaffold, ActiveScaffold::Routing::Basic.new(association: true)
  resources :billings, concerns: :active_scaffold
  root to: 'billings#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
