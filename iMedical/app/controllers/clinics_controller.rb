class ClinicsController < ApplicationController

    def index
        @owner = Owner.find(params[:owner_id])
        @clinics = @owner.clinics
    end

    def show
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

    def showClinics
        @owner = Owner.find(params[:owner_id])
        @clinics = @owner.clinics
    end

    def searchDoctor
        session[:clinic_id] = Clinic.find(params[:id])
		@doctors = Doctor.all.order('created_at DESC')
		@doctors = @doctors.search(params[:search]) if params[:search].present?
	end

	def addNewSecretary
		@secretaries = Secretary.all.order('created_at DESC')
		@secretaries = @secretaries.search(params[:search]) if params[:search].present?
	end

    private

    def clinic_params
        params.require(:clinic).permit(:name, :address, :description)
    end

end
