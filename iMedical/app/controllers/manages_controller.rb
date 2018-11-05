class ManagesController < ApplicationController
	load_and_authorize_resource
    def new
        @manage = Manage.new
    end

    def addNewSecretary
        if(session[:type] == "Owner")
            @secretary = User.get_secretaries.find(params[:secretary_id])
            @clinic = Clinic.find(params[:clinic_id])
            @manage = Manage.new(manage_params)
            @manage.save!
            #@secretary.manages << @manage
            #@clinic.manages << @manage
            redirect_to new_owner_path(@clinic.owner_id)
        end
    end

	def destroy
		@manage = Manage.find(params[:id])
		clinic = Clinic.find(@manage.clinic_id)
		secretary = User.get_secretaries.find(@manage.secretary_id)
		@manage.delete
		redirect_to owner_clinic_secretaries_path(clinic, secretary)
	end

    private

    def manage_params
        params.permit(:secretary_id, :clinic_id)
    end

end
