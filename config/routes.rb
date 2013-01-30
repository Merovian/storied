Storied::Application.routes.draw do
  root :to => 'ideas#index'
  resources :characters, only: [:index, :new, :create, :show, :edit]
end
