class ClinicsController < ApplicationController
	load_and_authorize_resource
	
    def index
        if(session[:type] == "Owner")
            @owner = User.get_owners.find(params[:owner_id])
            @clinics = @owner.clinics
        else
            @secretary = User.get_secretaries.find(params[:secretary_id])
            @clinics = @secretary.clinics
        end

    end

    def show
		# If the user is a patient I show the doctors that work in this clinic
        if(session[:type] == "Patient")
            @clinic = Clinic.find(params[:id])
        end
		# If the user is a secretary I show the doctors that work in this clinic
		# If the user is a owner I show.. nothing?
		puts session
		puts params
		clinic = Clinic.find(params[:id])
		case session[:type]
			when "Doctor"
				# If the user is a doctor I show his patients
				# The doctor id is stored in session[:user_id]
				redirect_to clinic_patients_path(clinic)
			when "Secretary"

			when "Patient"

			when "Owner"
				@owner = User.get_owners.find(params[:owner_id])
				@clinics = @owner.clinics
		end
    end

    def calendar
        if(session[:type])
            @clinic = Clinic.find(params[:id])
        end
    end

    def new
        @clinic = Clinic.new
    end

    def create
        @owner = User.get_owners.find(params[:owner_id])
        @clinic = @owner.clinics.create!(clinic_params)
        @clinic.owner_id = current_user.id
        @clinic.save
        redirect_to new_owner_path(params[:owner_id])
    end

    def edit
        @owner = User.get_owners.find(params[:owner_id])
        @clinic = Clinic.find(params[:id])
    end

    def update
        @owner = User.get_owners.find(params[:owner_id])
        @clinic = Clinic.find(params[:id])
        @clinic.update(clinic_params)
        redirect_to new_owner_path(params[:owner_id])
    end

    def showClinics
        @secretary = User.get_secretaries.find(params[:secretary_id])
        @clinics = @secretary.clinics
    end

    # Owner's functions

    def showClinicsForDoctor
        @owner = User.get_owners.find(params[:owner_id])
        @clinics = @owner.clinics
    end

    def showClinicsForSecretary
        @owner = User.get_owners.find(params[:owner_id])
        @clinics = @owner.clinics
    end

    def searchDoctor
        if(session[:type] == "Owner")
            session[:clinic_id] = Clinic.find(params[:id])
		    @doctors = User.get_doctors.all.order('created_at DESC')
		    @doctors = @doctors.search(params[:search]) if params[:search].present?
        elsif(session[:type] == "Secretary")
            session[:clinic_id] = Clinic.find(params[:id])
			@doctors = User.get_doctors.all.order('created_at DESC')
		    @doctors = @doctors.search(params[:search]) if params[:search].present?
        end
	end

	def searchSecretary
        session[:clinic_id] = Clinic.find(params[:id])
		@secretaries = User.get_secretaries.all.order('created_at DESC')
		@secretaries = @secretaries.search(params[:search]) if params[:search].present?
	end

    private

    def clinic_params
        params.require(:clinic).permit(:name, :address, :description, :province, :city, :latitude, :longitude)
    end

	# Method to verify if the user with the actual role can go in this page
	def verifyRole
		# The role is set in session variable :role
	end

end
