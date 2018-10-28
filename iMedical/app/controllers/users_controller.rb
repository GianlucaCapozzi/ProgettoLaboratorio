class UsersController < ApplicationController

	def new
		@user = User.new
	end

	def index
		# Different view for every role
		puts params
		#puts session[:role]
		case session[:type]
			when "Doctor"
				case params[:type]
					when "Doctor"
						
					when "Secretary"
					
					when "Owner"
					
					when "Patient"
						# List of patients if the user has connected as Doctor
						# The doctor id is stored in session[:user_id]
						@patients = Patient.joins("INNER JOIN examinations ON users.id = examinations.patient_id").where("examinations.doctor_id = ?", session[:user_id])
						puts params
						@clinic = Clinic.find(params[:clinic_id])
						render "doctorPatients"
				end
			when "Secretary"
			
			when "Owner"
			
			when "Patient"
				@users= User.all.order('created_at DESC')
				@users = @users.search(params[:search]) if params[:search].present?
		end
	end

	def show
		puts params
		# Role of the session
		case session[:type]
			when "Doctor"
				case params[:type]
					when "Doctor"
						# La vista dovrebbe variare in base a ciò che è l'utente, memorizzare nella sessione che cosa è l'utente?
						# Ovvero quando clicca quale tipo di utenza è, memorizzarla nella sessione
						# Select all clinics where the doctor works ( i'm a doctor ancora non controllato )
						#@clinics = Clinic.joins("INNER JOIN works ON works.clinic_id = clinics.id").where("works.doctor_id = ?", session[:user_id])
						@clinics = Clinic.joins("INNER JOIN works ON works.clinic_id = clinics.id").where("works.doctor_id = ?", session[:user_id])
						puts @clinics.all
						puts session[:user_id]
						render 'showDoctor'
					when "Secretary"

					when "Owner"

					when "Patient"
						# See the menu where i can choose my examination of the patient on the selected clinic 
						patient = Patient.find(params[:id])
						clinic = Clinic.find(params[:clinic_id])
						redirect_to clinic_patient_examinations_path(clinic, patient)
				end
			when "Secretary"
			
			when "Owner"
			
			when "Patient"
				case params[:type]
					when "Doctor"
						# Patients want to see doctor and wants to book an examination
						# I need doctor id and clinic id
						if params[:date] == nil
							redirect_to clinic_doctor_path(params[:clinic_id], params[:id])+"?date="+DateTime.now.to_date.to_s
						else
							@clinic = Clinic.find(params[:clinic_id])
							@doctor = Doctor.find(params[:id])
							@examinations = getExaminations()
							@nextDay = (params[:date].to_date + 1.days).to_s
							@previousDay = (params[:date].to_date - 1.days).to_s
							@startDateTime = params[:date]+" 09:00:00"
							@endDateTime = params[:date]+" 18:00:00"
							@bookableDates = getBookableDates(@examinations, @startDateTime, @endDateTime)
							puts @bookableDates
							render "patientDoctorShow"
						end
					when "Secretary"
					
					when "Owner" 
					
					when "Patient"
				end
		end
		
		# In params[:type] i have the type of what i want to see (Doctor, Secretary, ecc)
		#case params[:type]
			#when "Doctor"
				# La vista dovrebbe variare in base a ciò che è l'utente, memorizzare nella sessione che cosa è l'utente?
				# Ovvero quando clicca quale tipo di utenza è, memorizzarla nella sessione
				# Select all clinics where the doctor works ( i'm a doctor ancora non controllato )
				#@clinics = Clinic.joins("INNER JOIN works ON works.clinic_id = clinics.id").where("works.doctor_id = ?", session[:user_id])
			#	@clinics = Clinic.joins("INNER JOIN works ON works.clinic_id = clinics.id").where("works.doctor_id = ?", session[:user_id])
			#	puts @clinics.all
			#	puts session[:user_id]
			#	render 'showDoctor'
			#when "Secretary"

			#when "Owner"

			#when "Patient"
		#end
	end

	def create
		@user = User.new(user_params)

		# We store all emails in lowercase to avoid duplicates and case-sensitive login errors
		@user.email.downcase!

		if @user.save
			session[:user_id] = @user.id
			flash[:notice] = "Account creato con successo"
			redirect_to "/home/show"
		else
			flash.now.alert = "Impossibile creare l'account."
			render :new
		end
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		user = User.find(params[:id])
		if user.update(user_params)
			redirect_to "/home/show"
		else
			flash[:errors] = user.errors.full_messages
			redirect_back fallback_location: root_path
		end
	end

	def newOwner
		user = User.find(params[:id])
		user.type = 'Owner'
		session[:type] = 'Owner'
		user.save!
	end

	def newDoctor
		user = User.find(params[:id])
		# Check if the user has set his doctorID
		if user.doctorID != nil
			# If it's set, redirect to the main page of doctor where he can choose its clinic
			session[:type] = "Doctor"
			redirect_to doctor_path(user)
		else
			# The user must set the doctorID
			redirect_to set_doctorid_path(user)
		end
	end

	def checkDoctorID
		user = User.find(params[:id])
	end

	# Method to get information about user that wants to set a doctorID
	def setDoctorID
		@user = User.find(params[:id])
	end

	# Method to check if the doctorID is valid. If it's valid it will be written on DB
	def patchDoctorID
		user = User.find(params[:id])
		path = Rails.root + "matricole.csv"
		doctorID = params[:doctorID]
		# Open the file with the doctors' ids and check if the information are correct
		# The file has records like SURNAME;NAME;BIRTHDATE(GG/MM/AAAA);BIRTHCITY;DOCTORID\n
		if File.exist?(path)
			File.foreach(path, "\n") do |row|
				# Remove the line feed at the end of the row
				row = row.chomp
				# Splitting the row using delimeter ;
				doctor = row.split(";")
				puts doctor
				if doctor[4] == doctorID && user.surname.downcase == doctor[0].downcase && user.name.downcase == doctor[1].downcase && user.birthdayDate == doctor[2] && user.birthdayPlace.downcase == doctor[3].downcase
					# Found the doctor in the file and the information are correct
					user.type = "Doctor"
					user.doctorID = doctor[4]
					user.save!
					puts "Trovato!"
				else
					puts "Non corrisponde"
				end
			end
		else
			puts "File non esistente"
		end
		redirect_to new_doctor_path(user)
	end



	def newPatient
		user = User.find(params[:id])
		user.type = 'Patient'
		session[:type] = 'Patient'
		user.save!
	end

	def newSecretary
		user = User.find(params[:id])
		user.type = 'Secretary'
		session[:type] = 'Secretary'
		user.save!
	end

	# Patient's functions

	def showPatientStory
		@patient = Patient.find(params[:id])
		puts @patient
	end

	def searchClinic
		@clinics = Clinic.all.order('created_at DESC')
		@clinics = @clinics.search(params[:search]) if params[:search].present?
	end
	
	def getExaminations
		# Get doctor's examinations date in a clinic and when the patients can get an examination
		# Date has format AAAA-MM-GG
		# Le date di apertura ancora devono essere implementate
		params.permit(:clinic_id, :id, :date)
		examinations = Examination.select("start_time").where("clinic_id = ? AND doctor_id = ? AND start_time >= ? AND start_time <= ?", params[:clinic_id], params[:id],params[:date]+" 00:00:00", params[:date]+" 23:59:59")
		examinations
	end

	# Get all the intervals of 30 minutes from startTime to endTime and the availability of that spot
	def getBookableDates(examinations, startTime, endTime)
		# Get all intervals of 30 minutes from start time to end time
		# Ex startTime = 9:00 endTime = 11:00 -> 9:00, 9:30, 10:00, 10:30, 11:00
		bookableDates = []
		time = startTime.to_datetime
		while time <= endTime
			bookable = checkDateAvailabilty(examinations, time)
			bookableDates.push([time, bookable])
			time = time + 30.minutes
		end
		bookableDates
	end
	
	# Check if at that datetime there is already an examination
	def checkDateAvailabilty(examinations, time)
		availability = true
		#puts "entro"
		#puts examinations
		examinations.each do |examination|
			if examination.start_time.to_datetime == time
				#puts "Occupato!"
				availability = availability & false
			end
		end
		availability
	end

	private

	def user_params
		params.require(:user).permit(:name, :surname, :email, :password, :password_confirmation, :birthdayDate, :birthdayPlace, :phoneNumber, :cf)
	end


end
