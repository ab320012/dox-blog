Rails.application.routes.draw do
  root 'articles#index'

  resources :pages, only: [:index, :show]
  resources :articles, only: [:index, :show] do
    collection do
      get :search_suggestions
    end
  end

  resources :authors, only: [:index]

  get 'components' => 'components#components', as: :components
  get 'admin' => 'administrator/articles#index', as: :admin

  namespace :administrator do
    resources :authors
    resources :articles, except: :show
    resources :pages, except: :show
  end
end
