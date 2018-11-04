class Ability
  include CanCan::Ability

	def initialize(user, session)
		# Define abilities for the passed in user here. For example:
		#
		#   user ||= User.new # guest user (not logged in)
		#   if user.admin?
		#     can :manage, :all
		#   else
		#     can :read, :all
		#   end
		#
		# The first argument to `can` is the action you are giving the user
		# permission to do.
		# If you pass :manage it will apply to every action. Other common actions
		# here are :read, :create, :update and :destroy.
		#
		# The second argument is the resource the user can perform the action on.
		# If you pass :all it will apply to every resource. Otherwise pass a Ruby
		# class of the resource.
		#
		# The third argument is an optional hash of conditions to further filter the
		# objects.
		# For example, here the user can only update published articles.
		#
		#   can :update, Article, :published => true
		#
		# See the wiki for details:
		# https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
		type = session[:type]
		can :newPatient, User
		can [:newDoctor, :setDoctorID, :patchDoctorID, :new, :create], User
		can :update, User do |utente|
			utente.id == session[:user_id]
		end
		can :newOauth, User
		can :newSecretary, User
		can :newOwner, User

		if type == "Doctor"
			can :read, Clinic
			#can [:read, :update], Doctor do |doctor|
			#	doctor.id == session[:user_id]
			#end
			can [:create, :update, :destroy, :read, :searchDrug], Prescription do |prescription|
				# Ottengo la visita relativa alla prescrizione su cui effettuare operazioni
				examination = Examination.find(prescription.examination_id)
				# Verifico che la prescrizione su cui effettuo le operazioni riferiscano
				# ad un dottore che lavora effettivamente in quella clinica
				work = Work.where("doctor_id = ? AND clinic_id = ?", session[:user_id], examination.clinic_id)
				examination.doctor_id == session[:user_id] && work.length > 0
			end
			#can :create, Prescription
			
			can :read, Examination do |examination|
				examination.doctor_id == session[:user_id]
			end
			can :read, Manage
			#can [:read, :update], Patient do |patient|
				# Verifico che sia un paziente del dottore
			#	examinations = Examination.where("patient_id = ? AND doctor_id = ?", patient.id, session[:user_id])
			#	examinations.length > 0
			#end
			can :read, Work do |work|
				work.doctor_id == session[:user_id]
			end
			can :read, User do |utente|
				# Verifico che sia un paziente del dottore oppure che sia l'utente stesso
				examinations = Examination.where("patient_id = ? AND doctor_id = ?", utente.id, session[:user_id])
				examinations.length > 0 || utente.id == session[:user_id]
			end
		end

		if type == "Patient"
			can [:read], Clinic
			#can :read, Doctor
			can :read, Prescription do |prescription|
				# Ottengo la visita relativa alla prescrizione
				examination = Examination.find(prescription.examination_id)
				examination.patient_id == session[:user_id]
			end
			can [:create, :read, :update, :destroy, :index], Examination do |examination|
				examination.patient_id == session[:user_id]
			end
			#can :create, Examination 
			can :read, Manage
			#can :read, Patient
			can :read, Work
			can [:read, :searchClinic], User
		end

		if type == "Secretary"
			can [:read, :showClinics, :searchDoctor], Clinic
			#can :read, Doctor
			can :read, Prescription do |prescription|
				# Ottengo la visita relativa alla prescrizione
				examination = Examination.find(prescription.examination_id)
				# Verifico che la clinica dove viene effettuata la visita sia gestita dal segretario attualmente connesso
				manage = Manage.where("secretary_id = ? AND clinic_id = ?", session[:user_id], examination.clinic_id)
				manage.length > 0 ? true : false
			end
			can [:read, :update, :destroy], Examination do |examination|
				#secretary = User.get_secretaries.find(session[:user_id])
				manage = Manage.where("secretary_id = ? AND clinic_id = ?", session[:user_id], examination.clinic_id)
				manage.length > 0 ? true : false
			end
			#can :read, Patient
			can :read, Work
			can :read, User
		end

		if type == "Owner"
			can [:manage], Clinic
			can [:manage], Manage do |manage|
				clinic = Clinic.find(manage.clinic_id)
				clinic.owner_id == session[:user_id]
			end
			#can :update, Owner
			can [:manage], Work do |work|
				clinic = Clinic.find(work.clinic_id)
				clinic.owner_id == session[:user_id]
			end
			can :read, User
		end
	end
end
