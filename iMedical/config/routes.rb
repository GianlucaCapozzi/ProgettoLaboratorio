Rails.application.routes.draw do

	get '/homepage/info' => 'homepage#info'

	get 'auth/:provider/callback', to: 'sessions#createOauth'
	get 'auth/failure', to: redirect('/')

	get 'users/new' => 'users#new', as: :new_user
	get 'users/:id/newOauth' => 'users#newOauth', as: :newOauth
	get 'users/show' => 'users#show'
	patch 'users/:id' => 'users#update'
	post 'users/new' => 'users#create'

	# Role chosing
	get 'users/:id/newOwner' => 'users#newOwner', as: :new_owner
	get 'users/:id/newDoctor' => 'users#newDoctor', as: :new_doctor
	get 'users/:id/newPatient' => 'users#newPatient', as: :new_patient
	get 'users/:id/newSecretary' => 'users#newSecretary', as: :new_secretary

	# Owner's routes
	get 'users/createClinic' => 'users#createClinic', as: :create_clinic
	get 'users/manageClinic' => 'users#manageClinic', as: :manage_clinic
	get 'users/addNewDoctor' => 'users#addNewDoctor', as: :add_new_doctor
	get 'users/addNewSecretary' => 'users#addNewSecretary', as: :add_new_secretary

	get '/login' => 'sessions#new'
	post '/login' => 'sessions#createLocal'
	delete '/logout' => 'sessions#destroy', as: :logout

	resources :sessions, only: [:create, :destroy]
	resources :home
	resources :users
	resources :homepage

	root "homepage#show"

end
