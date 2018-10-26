class User < ApplicationRecord

	has_secure_password

	validates :email, format: { with:  /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i, message: 'Per favore inserisci una mail valida' }, allow_blank: true, presence: true, uniqueness: true
	#validates :phoneNumber, format: { with: /\A(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}\z/, message: "Per favore inserisci un numero di telefono valido" }, allow_blank: true

	def self.from_omniauth(auth)
		where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
			user.provider = auth.provider
			user.uid = auth.uid
			user.name = auth.info.name
			user.email = auth.info.email
			user.password_digest = auth.credentials.token
			user.oauth_expires_at = Time.at(auth.credentials.expires_at)
			user.save!
		end
	end

	def self.search(search_term)
        where("LOWER(name) LIKE ?", "%#{search_term.downcase}%")
    end

	def upcoming_examinations
		examinations.order(start_time: :desc).select { |a| a.start_time > (DateTime.now) }
	end

end
