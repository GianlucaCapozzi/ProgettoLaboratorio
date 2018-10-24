class ClinicsController < ApplicationController

    def index


    end
    
    def show
		# If the user is a patient I show the doctors that work in this clinic
		# If the user is a secretary I show the doctors that work in this clinic
		# If the user is a owner I show.. nothing?
		puts session
		puts params
		clinic = Clinic.find(params[:id])
		case session[:role]
			when "Doctor"
				# If the user is a doctor I show his patients
				# The doctor id is stored in session[:user_id]
				redirect_to clinic_patients_path(clinic)
			when "Secretary"
			
			when "Patient"
			
			when "Owner"
				@owner = Owner.find(params[:owner_id])
				@clinics = @owner.clinics
		end
    end

    def new
        @clinic = Clinic.new
    end

    def create
        @owner = Owner.find(params[:owner_id])
        @clinic = @owner.clinics.create!(clinic_params)
        @clinic.owner_id = current_user.id
        @clinic.save
        redirect_to new_owner_path(params[:owner_id])
    end

    def edit
        @owner = Owner.find(params[:owner_id])
        @clinic = Clinic.find(params[:id])
    end

    def update
        @owner = Owner.find(params[:owner_id])
        @clinic = Clinic.find(params[:id])
        @clinic.update(clinic_params)
        redirect_to new_owner_path(params[:owner_id])
    end

    # Owner's functions

    def showClinicsForDoctor
        @owner = Owner.find(params[:owner_id])
        @clinics = @owner.clinics
    end

    def showClinicsForSecretary
        @owner = Owner.find(params[:owner_id])
        @clinics = @owner.clinics
    end

    def searchDoctor
        session[:clinic_id] = Clinic.find(params[:id])
		@doctors = Doctor.all.order('created_at DESC')
		@doctors = @doctors.search(params[:search]) if params[:search].present?
	end

	def searchSecretary
        session[:clinic_id] = Clinic.find(params[:id])
		@secretaries = Secretary.all.order('created_at DESC')
		@secretaries = @secretaries.search(params[:search]) if params[:search].present?
	end

    private

    def clinic_params
        params.require(:clinic).permit(:name, :address, :description)
    end
	
	# Method to verify if the user with the actual role can go in this page
	def verifyRole
		# The role is set in session variable :role
	end

end
