Rails.application.routes.draw do
  devise_for :users, :path_names => { :sign_up => "register" }
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
