class Doctor < User

    belongs_to :work, optional: true
    belongs_to :examination, optional: true

    def self.search(search_term)
        where("LOWER(name) LIKE ?", "%#{search_term.downcase}%")
    end

end
