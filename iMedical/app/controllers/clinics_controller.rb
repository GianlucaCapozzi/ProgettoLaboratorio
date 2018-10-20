class ClinicsController < ApplicationController

    def index
            @clinics = Clinic.all
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
            @clinic = Clinic.find(params[:owner_id])
        end

        def update
            @clinic = Clinic.find(params[:owner_id])
            @clinic.update.attributes!(clinic_params)
            redirect_to new_owner_path(params[:owner_id])
        end

        private

        def clinic_params
            params.require(:clinic).permit(:name, :address, :description)
        end

end
