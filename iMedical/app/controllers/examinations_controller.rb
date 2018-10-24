class ExaminationsController < ApplicationController
	require 'date'

	def index
		case session[:type]
			when "Doctor"
				#List of examination
				@examinations = Examination.where("clinic_id = ? AND patient_id = ?", params[:clinic_id], params[:patient_id])
				#puts @examinations
				render 'clinicDoctorPatient'
			when "Secretary"
				#List of examination
			when "Patient"
				#List of examination
				@patient = Patient.find(current_user.id)
				@examinations = @patient.examinations
			when "Owner"	
				#Nothing?
		end

	end
	
	def show
		case session[:type]
			when "Doctor"
				# See the existing examinations and he can create them
				@examination = Examination.find(params[:id])
				@doctor = Doctor.find(@examination.doctor_id)
				@clinic = Clinic.find(@examination.clinic_id)
				#@prescriptions = @examination.prescriptions
				render 'examinationShow'
			when "Secretary"
				
			when "Patient"
				
			when "Owner"	
				
		end
	end
	
	def new
		@examination = Examination.new
	end
	
	def create
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
