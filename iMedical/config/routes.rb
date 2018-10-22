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
	get '/owner/:owner_id/clinics/showClinics' => 'clinics#showClinics', as: :show_clinics
	get '/owner/:owner_id/clinics/:id/searchDoctor' => 'clinics#searchDoctor', as: :search_doctor
	get '/owner/:owner_id/clinics/:id/searchSecretary' => 'clinics#searchSecretary', as: :search_secretary
	get '/work/addNewDoctor/:doctor_id&:clinic_id' => 'works#addNewDoctor', as: :add_new_doctor
	get '/manage/addNewSecretary/:secretary:id&clinic.id' => 'manages#addNewSecretary', as: :add_new_secretary

	# Patient's routes
	get '/patient/:id/showStory' => 'users#showPatientStory', as: :show_patient_story
	get '/patient/searchClinic' => 'users#searchClinic', as: :search_clinic

	get '/login' => 'sessions#new'
	post '/login' => 'sessions#createLocal'
	delete '/logout' => 'sessions#destroy', as: :logout

	resources :sessions, only: [:create, :destroy]
	resources :home
	resources :users
	resources :doctors, controller: 'users', type: 'Doctor'
	resources :secretaries, controller: 'users', type: 'Secretary'
	resources :patient, controller: 'users', type: 'Patient'
	resources :owner, controller: 'users', type: 'Owner' do
		resources :clinics
	end
	resources :works do
		resources :clinics
		resources :doctors
	end
	resources :homepage

	root "homepage#show"

end
