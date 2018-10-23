class Secretary < User

   has_many :manages
   has_many :clinics, through: :manages

    def self.search(search_term)
        where("LOWER(name) LIKE ?", "%#{search_term.downcase}%")
    end

end
