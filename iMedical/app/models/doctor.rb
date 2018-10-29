class Doctor < User

    has_many :works
    has_many :examinations

    def self.search(search_term)
        where("LOWER(name) LIKE ?", "%#{search_term.downcase}%")
    end

end
