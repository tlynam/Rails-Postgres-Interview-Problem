Rails.application.routes.draw do
  root 'categories#index'

  resource :categories, only: :index
end
