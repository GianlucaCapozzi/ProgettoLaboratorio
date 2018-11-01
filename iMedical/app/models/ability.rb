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
		can :manage, User, :id => user.id
		if type == "Doctor"
			can :read, Clinic
			can [:read, :update], Doctor
			can :read, Prescription
			can [:read, :update, :destroy], Examination
			can :read, Manage
			can [:read, :update], Patient
			can :read, Work
			can :update, User
		end
		
		if type == "Patient"
			can :read, Clinic
			can [:read, :update], Doctor
			can [:read, :update, :create, :destroy], Prescription
			can :read, Examination
			can :read, Manage
			can :read, Patient
			can :read, Work
			can :update, User
		end
		
		if type == "Secretary"
			can :read, Clinic
			can :read, Doctor
			can :read, Prescription
			can [:read, :update, :destroy], Examination
			can :read, Patient
			can :read, Work
			can :update, User
		end
		
		if type == "Owner"
			can [:create, :read, :update, :destroy], Clinic
			can [:create, :read, :update, :destroy], Manage
			can :update, Owner
			can [:create, :read, :update, :destroy], Work
			can :update, User
		end
	end
end