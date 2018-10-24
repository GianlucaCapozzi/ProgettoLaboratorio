class ExaminationsController < ApplicationController
	require 'date'

	def index
		case session[:role]
			when "Doctor"
				#List of examination
				@examinations = Examination.where("clinic_id = ? AND patient_id = ?", params[:clinic_id], params[:patient_id])
				#puts @examinations
				render 'clinicDoctorPatient'
			when "Secretary"
				#List of examination
			when "Patient"
				#List of examination
			when "Owner"	
				#Nothing?
		end

	end
	
	def show
		case session[:role]
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
	end
	
	def create
	end

	#def date:Datetime
	#end

	#def diagnosis:String
	#end
end
