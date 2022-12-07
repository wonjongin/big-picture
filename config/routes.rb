Rails.application.routes.draw do
  get 'basic/index'
  get 'basic/index/:text', to: 'basic#index'
  get 'basic/time'


  get 'auth/google', to: redirect('/auth/google_oauth2')
  # get 'auth/google'
  get 'auth/google_oauth2/callback', to: 'auth#google'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
