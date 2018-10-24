class PrescriptionsController < ApplicationController
	
	def index
		case session[:role]
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
	end
	
	def create
	end
	
	def new
	end


  #def type:String
  #end

  #def comment:String
  #end

  #def medicinalName:String
  #end
end
