Rails.application.routes.draw do
  get 'products/index'
  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/api-docs'
  get 'points/index'
  scope :api, defaults: { format: :json } do
    devise_for :users, controllers: { sessions: :sessions, confirmations: :confirmations},
                     path_names: { sign_in: :login }

    resource :user, only: [:update, :show]
    get 'user/auto_login', to: 'users#auto_login'
    resources :purchases, only: [:create]
    resources :rewards, only: [:create]

    

  end
end
