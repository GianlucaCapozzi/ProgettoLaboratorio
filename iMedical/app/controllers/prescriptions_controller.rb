class PrescriptionsController < ApplicationController	
	load_and_authorize_resource	
	skip_authorize_resource :only => [:create, :new]
	def index
		case session[:type]
			when "Doctor"
				# List of prescriptions of the selected examination
				@examination = Examination.find(params[:examination_id])
				@prescriptions = @examination.prescriptions
				render "doctorPrescriptionsIndex"
			when "Secretary"
				#@examination = Examination.find(params[:examination_id])
				#@prescriptions = @examination.prescriptions	
			when "Patient"
				#@patient = Patient.find(params[:patient_id])
				@examination = Examination.find(params[:examination_id])
				@prescriptions = @examination.prescriptions
				render "patientPrescriptionsIndex"
			when "Owner"	
		end
	end
	
	def show
		@prescription = Prescription.find(params[:id])
		case session[:type]
			when "Doctor"
				case @prescription.type
					when "Drug"
						render "doctorDrugShow"
					when "PrescriptedExamination"
						render "doctorPrescriptedExaminationShow"
				end
			when "Secretary"
			
			when "Patient"
				case @prescription.type
					when "Drug"
						render "doctorDrugShow"
					when "PrescriptedExamination"
						render "doctorPrescriptedExaminationShow"
				end
			when "Owner"	
		end
	end
	
	def new
		case session[:type]
			when "Doctor"
				case params[:type]
					when "Drug"
						@examination = Examination.find(params[:examination_id])
						@prescription = @examination.prescriptions.new
						@prescription.type = "PrescriptedExamination"
						render "doctorDrugPrescriptionNew"
					when "PrescriptedExamination"
						@examination = Examination.find(params[:examination_id])
						@prescription = @examination.prescriptions.new
						@prescription.type = "PrescriptedExamination"
						render "doctorPrescriptionsNew"
				end
			when "Secretary"
				#Nothing
			when "Patient"
				#Nothing
			when "Owner"	
				#Nothing
		end
	end

	def create
		params.require(:type)
		prescription = Prescription.new
		case session[:type]
			when "Doctor"
				params.require(:examination_id)
				@examination = Examination.find(params[:examination_id])
				case params[:type]
					when "Drug"
						params.require(:prescription).permit(:comment, :drugName)
						prescription.comment = params[:prescription][:comment]
						prescription.drugName = params[:prescription][:drugName]
						prescription.type = params[:type]
						prescription.examination_id = params[:examination_id]	
					when "PrescriptedExamination"
						params.require(:prescription).permit(:comment)
						prescription.comment = params[:prescription][:comment]
						prescription.type = params[:type]
						prescription.examination_id = params[:examination_id]
				end
				authorize! :create, prescription
				prescription.save
				redirect_to examination_prescriptions_path(@examination)
			when "Secretary"
			
			when "Patient"
				redirect_to patient_prescriptions_path(current_user.id)
			when "Owner"
		end
	end
	
	def edit
		@prescription = Prescription.find(params[:id])
		case @prescription.type
			when "Drug"
				render "doctorDrugEdit"
			when "PrescriptedExamination"
				render "doctorPrescriptedExaminationEdit"
		end
	end
	
	def update
		prescription = Prescription.find(params[:id])
		examination = Examination.find(prescription.examination_id)
		case prescription.type
			when "Drug"
				prescription.drugName = params[:drug][:drugName]
				prescription.comment = params[:drug][:comment]
			when "PrescriptedExamination"
				prescription.comment = params[:prescripted_examination][:comment]
		end
		prescription.save
		redirect_to examination_prescriptions_path(examination)
	end
	
	def destroy
		prescription = Prescription.find(params[:id])
		examination = Examination.find(prescription.examination_id)
		Prescription.delete(params[:id])
		redirect_to examination_prescriptions_path(examination)
	end
	
	def searchDrug
		if params[:name].length > 3
			render :json => Drug.search(params[:name])
		end
	end

  #def type:String
  #end

  #def comment:String
  #end

  #def medicinalName:String
  #end
   # def create
     #   if(session[:type] == "Doctor")
      #      @examination = Examination.find(params[:examination_id])
      #      @prescription = @examination.prescriptions.create!(prescription_params)
      #      @prescription.examination_id = @examination.id
      #      @prescription.save
      #      redirect_to new_doctor_path(current_user.id)
      #  else
      #      redirect_to patient_prescriptions_path(current_user.id)
     #   end
   #  end

    private

    def prescription_params
        params.require(:prescription).permit(:type, :comment, :drugName)
    end


end
