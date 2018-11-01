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
            @secretary.manages << @manage
            @clinic.manages << @manage
            redirect_to new_owner_path(@clinic.owner_id)
        end
    end

    private

    def manage_params
        params.permit(:secretary_id, :clinic_id)
    end

end
