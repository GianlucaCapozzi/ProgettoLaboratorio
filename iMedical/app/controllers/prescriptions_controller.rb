class PrescriptionsController < ApplicationController

    def new
        @prescription = Prescription.new
    end

    def create
        if(session[:type] == "Doctor")
            @examination = Examination.find(params[:examination_id])
            @prescription = @examination.prescriptions.create!(prescription_params)
            @prescription.examination_id = @examination.id
            @prescription.save
            redirect_to new_doctor_path(current_user.id)
        else
            redirect_to patient_prescriptions_path(current_user.id)
        end
    end

    def index
        if(session[:type] == "Patient")
            @patient = Patient.find(params[:patient_id])
            @prescriptions = @patient.prescriptions
        end
    end

    private

    def prescription_params
        params.require(:prescription).permit(:type, :comment, :drugName)
    end

end
