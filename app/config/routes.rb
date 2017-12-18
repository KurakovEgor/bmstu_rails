Rails.application.routes.draw do
  get 'perfect_numbers/index'
  get 'perfect_numbers/result'

  root 'perfect_numbers#index'

  get 'session/login'

  post 'session/create'

  get 'session/logout'

  resources :users

end
