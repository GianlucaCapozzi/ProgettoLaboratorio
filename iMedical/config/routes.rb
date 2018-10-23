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


	# Checking/setting doctorID
	get 'users/:id/setDoctorID' => 'users#setDoctorID', as: :set_doctorid
	patch 'users/:id/setDoctorID' => 'users#patchDoctorID', as: :patch_doctorid

	# Owner's routes
	get 'users/addNewDoctor' => 'users#addNewDoctor', as: :add_new_doctor
	get 'users/addNewSecretary' => 'users#addNewSecretary', as: :add_new_secretary

	# Patient's routes
	get 'patient/:id/showStory' => 'users#showPatientStory', as: :show_patient_story
	

	get '/login' => 'sessions#new'
	post '/login' => 'sessions#createLocal'
	delete '/logout' => 'sessions#destroy', as: :logout

	resources :sessions, only: [:create, :destroy]
	resources :home
	resources :users
	#resources :doctors, controller: 'users', type: 'Doctor' do
	#	resources :clinics, shallow: true do
	#		resources :patient, controller: 'users', type: 'Patient', shallow: true do
	#			resources :examinations, shallow: true do
	#				resources :prescriptions
	#			end
	#		end
	#	end
	#end
	
	# I want to see where the given doctor works
	resources :doctors, controller: 'users', type: 'Doctor' do
		resources :clinics, shallow: true, only: [:index, :show]
	end
	# I want to see the patient that had a visit in the given clinic
	resources :clinics do
		resources :patients, shallow: true, only: [:index, :show]
	end
	# I want to see the visits of a patient
	resources :patients, controller: 'users', type: 'Patient' do
		resources :examinations, shallow: true, only: [:index, :show]
	end
	# I want to see the prescriptions of a examinations
	resources :examinations do
		resources :prescriptions, shallow: true
	end
	
	
	resources :secretaries, controller: 'users', type: 'Secretary'
	#resources :patient, controller: 'users', type: 'Patient'
	resources :owner, controller: 'users', type: 'Owner' do
		resources :clinics
	end
	resources :homepage

	root "homepage#show"

end
