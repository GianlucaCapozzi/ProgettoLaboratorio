class Secretary < User

    belongs_to :Manage

    def self.search(search_term)
        where("LOWER(name) LIKE ?", "%#{search_term.downcase}%")
    end

end
