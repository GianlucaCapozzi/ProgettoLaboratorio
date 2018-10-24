class ExaminationsController < ApplicationController

    def index
        if(session[:type] == "Patient")
            @patient = Patient.find(current_user.id)
            @examinations = @patient.examinations
        end
    end

    def new
        @examination = Examination.new
    end

    def createExamination
        if(session[:type] == "Patient")
            @patient = Patient.find(current_user.id)
            @clinic = Clinic.find(params[:clinic_id])
            @doctor = Doctor.find(params[:doctor_id])
            @examination = Examination.new(examination_params)
            @examination.save!
            @clinics.examinations << @examination
            @patient.examinations << @examination
            @doctor.examinaions << @examination
        end
    end

    private

    def examination_params
        params.permit(:patient_id, :doctor_id, :clinic_id)
    end

end
