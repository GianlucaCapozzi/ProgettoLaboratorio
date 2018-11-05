class User < ApplicationRecord

	attr_accessor :remember_token, :activation_token, :reset_token, :actual_role
	before_save :downcase_email
	before_create :create_activation_digest
	validates :name, presence: true, length: { maximum: 50 }
	validates :surname, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
	VALID_PHONE_REGEX = /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/
	validates :phoneNumber, format: { with: VALID_PHONE_REGEX }, uniqueness: true
	validates :password, presence: true, length: { minimum: 5 }, :if => :not_social?
	VALID_CF_REGEX = /\A(?:(?:[B-DF-HJ-NP-TV-Z]|[AEIOU])[AEIOU][AEIOUX]|[B-DF-HJ-NP-TV-Z]{2}[A-Z]){2}[\dLMNP-V]{2}(?:[A-EHLMPR-T](?:[04LQ][1-9MNP-V]|[1256LMRS][\dLMNP-V])|[DHPS][37PT][0L]|[ACELMRT][37PT][01LM])(?:[A-MZ][1-9MNP-V][\dLMNP-V]{2}|[A-M][0L](?:[1-9MNP-V][\dLMNP-V]|[0L][1-9MNP-V]))[A-Z]\z/i
	validates :cf, presence: true, format: { with: VALID_CF_REGEX }, uniqueness: { case_sensitive: false }

	has_secure_password

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.name = auth.info.name
			user.email = auth.info.email
			user.password_digest = auth.credentials.token
			user.oauth_expires_at = Time.at(auth.credentials.expires_at)
			user.roles_mask = 0
			user.activate
			user.save!(validate: false)
		end
	end

	def self.search(search_term)
        where("LOWER(name) LIKE ?", "%#{search_term.downcase}%")
    end

	def self.get_patients
		where("roles_mask & 4 == 4")
	end

	def self.get_owners
		where("roles_mask & 1 == 1")
	end

	def self.get_secretaries
		where("roles_mask & 2 == 2")
	end

	def self.get_doctors
		where("roles_mask & 8 == 8")
	end


	# Return the hash digest of the given string
	def User.digest(string)
		cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
		BCrypt::Password.create(string, cost: cost)
	end

	# Return a random token
	def User.new_token
		SecureRandom.urlsafe_base64
	end

	# Activate an account
	def activate
		update_attribute(:activated,    true)
    	update_attribute(:activated_at, Time.zone.now)
	end

	# Sends activation email
	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end

	# Remember a user in the database for use in persisten sessions
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	# Return true if the given tpken matches the digest
	def authenticated?(attribute, token)
		digest = send("#{attribute}_digest")
		return false if digest.nil?
		BCrypt::Password.new(digest).is_password?(token)
	end

	# Forget a user
	def forget
		update_attribute(:remember_digest, nil)
	end

	# Sets the password reset attributes
	def create_reset_digest
		self.reset_token = User.new_token
		update_attribute(:reset_digest, User.digest(reset_token))
		update_attribute(:reset_sent_at, Time.zone.now)
	end

	# Sends password reset email
	def send_password_reset_email
		UserMailer.password_reset(self).deliver_now
	end

	# Return true if a password reset
	def password_reset_expired?
		reset_sent_at < 2.hours.ago
	end

	def not_social?
		provider.blank?
	end


	private

	# Converts email to all lower-case
	def downcase_email
		self.email = email.downcase
	end

	# Creates and assigns the activation token and digest
	def create_activation_digest
		self.activation_token = User.new_token
		self.activation_digest = User.digest(activation_token)
	end

end
