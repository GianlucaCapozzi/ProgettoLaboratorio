class Doctor < User

    belongs_to :Works, optional: true
    belongs_to :Examinations, optional: true

    def self.search(search_term)
        where("LOWER(name) LIKE ?", "%#{search_term.downcase}%")
    end

end
