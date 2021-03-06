Rails.application.routes.draw do

	get 'auth/:provider/callback', to: 'sessions#createOauth'
	get 'auth/failure', to: redirect('/')

	# Role chosing
	get 'users/:id/newOwner' => 'users#newOwner', as: :new_owner
	get 'users/:id/newDoctor' => 'users#newDoctor', as: :new_doctor
	get 'users/:id/newPatient' => 'users#newPatient', as: :new_patient
	get 'users/:id/newSecretary' => 'users#newSecretary', as: :new_secretary
	get 'users/:id/newOauth' => 'users#newOauth', as: :newOauth


	# Checking/setting doctorID
	get 'users/:id/setDoctorID' => 'users#setDoctorID', as: :set_doctorid
	patch 'users/:id/setDoctorID' => 'users#patchDoctorID', as: :patch_doctorid

	# Owner's routes
	get '/owner/:owner_id/clinics/showClinicsForDoctor' => 'clinics#showClinicsForDoctor', as: :show_clinicsDoctor
	get '/owner/:owner_id/clinics/showClinicsForSecretary' => 'clinics#showClinicsForSecretary', as: :show_clinicsSecretary
	get '/owner/:owner_id/clinics/:id/searchDoctor' => 'clinics#searchDoctor', as: :search_doctor
	get '/owner/:owner_id/clinics/:id/searchSecretary' => 'clinics#searchSecretary', as: :search_secretary
	get '/work/addNewDoctor/:doctor_id&:clinic_id' => 'works#addNewDoctor', as: :add_new_doctor
	get '/manage/addNewSecretary/:secretary_id&:clinic_id' => 'manages#addNewSecretary', as: :add_new_secretary

	#Secretary's routes
	get '/secretary/:secretary_id/clinics/showClinics' => 'clinics#showClinics', as: :show_clinics
    get '/secretary/:secretary_id/clinics/:clinic_id/doctors/:doctor_id/searchPatient' => 'users#searchPatient', as: :search_patient

	# Patient's routes
	get '/patient/:id/showStory' => 'users#showPatientStory', as: :show_patient_story
	get '/patient/searchClinic' => 'users#searchClinic', as: :search_clinic
	get '/patient/clinics/:clinic_id/showDoctors/:doctor_id/createExamination' => 'examinations#createExamination', as: :create_examination

	# Clinics

	get '/clinics/:id' => 'clinics#show', as: :clinics_show
	#get 'examinations/calendar', as: :examinations_calendar

	get '/login' => 'sessions#new'
	post '/login' => 'sessions#createLocal'
	delete '/logout' => 'sessions#destroy', as: :logout

	resources :sessions, only: [:create, :destroy, :new]
	resources :home, only: [:show]
	resources :users, only: [:show, :new, :create, :destroy, :update, :edit, :index ]
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
	resources :doctors, controller: 'users', type: 'Doctor', only: [:index, :show] do
		resources :clinics, shallow: true, only: [:index, :show]
	end
	# I want to see the patient that had a visit in the given clinic
	resources :clinics, only: [:index, :show] do
		resources :patients, controller: 'users', type: 'Patient', only: [:index, :show] do
			resources :examinations, only: [:index]
		end
		#resources :doctors, controller: 'user', type: 'Doctor', shallow: true
		resources :doctors, controller: 'users', type: 'Doctor', only: [:index, :show] do
			resources :examinations, only: [:create, :index]
		end
	end
	# I want to see the visits of a patient
	resources :patients, controller: 'users', type: 'Patient', only: [:index, :show] do
		resources :examinations, shallow: true, only: [:index, :show, :create]
		#resources :prescriptions, shallow: true
	end
	# I want to see the prescriptions of a examinations
	resources :examinations do
		resources :prescriptions, shallow: true
		resources :drugs, controller: 'prescriptions', type: 'Drug', only: [:new, :create]
		resources :prescriptedExaminations, controller: 'prescriptions', type: 'PrescriptedExamination', only: [:new, :create]
	end

	# Route to search drug
	get '/searchDrug', to: 'prescriptions#searchDrug', as:  :search_drug

	resources :secretaries, controller: 'users', type: 'Secretary', only: [:index, :show] do
		resources :clinics, shallow: true, only: [:index, :show]
	end

	#resources :patient, controller: 'users', type: 'Patient'
	resources :manages, only: [:new, :destroy] do
		#resources :clinics
		#resources :secretaries
	end

	resources :owner, controller: 'users', type: 'Owner', only: [:show] do
		resources :clinics do
			resources :doctors, controller: 'users', type: 'Doctor', only: [:index, :show]
			resources :secretaries, controller: 'users', type: 'Secretary', only: [:index]
		end
	end
	resources :works, only: [:new, :create, :destroy] do
		#resources :clinics
		#resources :doctors
	end
	resources :homepage, only: [:index]
	resources :account_activations, only: [:edit]
    resources :password_resets, only: [:new, :create, :edit, :update]

	root "homepage#index"

end
