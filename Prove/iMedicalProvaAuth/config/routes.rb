Rails.application.routes.draw do

	get 'auth/:provider/callback', to: 'sessions#createOauth'
	get 'auth/failure', to: redirect('/')
	get 'signout', to: 'sessions#destroy', as: 'signout'

	get 'users/new' => 'users#new', as: :new_user
	get 'users/:id/newOauth' => 'users#newOauth', as: :newOauth
	patch 'users/:id' => 'users#update'
	post 'users/new' => 'users#createLocal'

	get '/login' => 'sessions#new'
	post '/login' => 'sessions#createLocal', as: :create2
	delete '/logout' => 'sessions#destroy'

	resources :sessions, only: [:create, :destroy]
	resources :home
	resources :users
	resources :homepage

	root "homepage#show"

end
