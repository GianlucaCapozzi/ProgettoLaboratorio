class PrescriptionsController < ApplicationController
	
	def index
		case session[:type]
			when "Doctor"
				# List of prescriptions of the selected examination
				@examination = Examination.find(params[:examination_id])
				@prescriptions = @examination.prescriptions
				render "doctorPrescriptionsIndex"
			when "Secretary"
			
			when "Patient"
			
			when "Owner"	
		end
	end
	
	def show
		case session[:type]
			when "Doctor"
				
			when "Secretary"
			
			when "Patient"
			
			when "Owner"	
		end
	end
	
	def create
		
	end
	
	def new
		case session[:type]
			when "Doctor"
				@examination = Examination.find(params[:examination_id])
				@prescription = @examination.prescriptions.new
				render "doctorPrescriptionsNew"
			when "Secretary"
				#Nothing
			when "Patient"
				#Nothing
			when "Owner"	
				#Nothing
		end
	end

	def create
	end

  #def type:String
  #end

  #def comment:String
  #end

  #def medicinalName:String
  #end
end
