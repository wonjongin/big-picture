Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      get 'community/index'
      get 'user/me'
      get 'user/my_logins'
    end
  end

  get 'basic/index'
  get 'basic/index/:text', to: 'basic#index'
  get 'basic/time'

  get 'auth/google', to: redirect('/auth/google_oauth2')
  # get 'auth/google'
  get 'auth/google_oauth2/callback', to: 'auth#google'
  post 'auth/login_google'
  post 'auth/refresh'
  get 'auth/logout'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
