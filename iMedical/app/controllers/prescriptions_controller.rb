class PrescriptionsController < ApplicationController
<<<<<<< HEAD
	
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
=======

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

>>>>>>> cc7f0ecf926a1e7f75810d501519bd0549a810d8
end
