class Doctor < User

    belongs_to :Works
    belongs_to :Examinations

    def self.search(search_term)
        where("LOWER(name) LIKE ?", "%#{search_term.downcase}%")
    end

end
