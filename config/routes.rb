Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }

  root 'startpage#index'
  post 'role_switch', to: 'startpage#role_switch', as: 'role_switch'

  scope 'admin' do
    resources :users, except: :show
    resources :static_pages, except: :show
  end

  get '/:slug', to: 'static_pages#show'
end
