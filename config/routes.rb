Storied::Application.routes.draw do
  root :to => 'ideas#index'
  resources :characters, :controller => "ideas", :type=>"Character", 
    only: [:index, :new, :create, :show, :edit, :update]
  resources :items, :controller => "ideas", :type=>"Item",
    only: [:index, :new, :create, :show, :edit, :update]
end
