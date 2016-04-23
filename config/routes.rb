Rails.application.routes.draw do

  root 'login#index'

  post 'login' => 'login#login'

  get 'login' => 'login#index'

  post 'login' => 'login#create'

  get 'logout' => 'login#logout'

  post 'reset' => 'login#reset'

  get 'password_modify' => 'login#password_modify'

  get 'modify' => 'login#modify'

  post 'update_password' => 'login#update_password'

  post 'modify_update' => 'login#modify_update'

  resources :admin

  resources :blog



end
