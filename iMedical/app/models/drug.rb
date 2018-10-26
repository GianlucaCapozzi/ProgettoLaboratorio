class Drug < Prescription

	def self.search(name)
		drugs = Array.new
		path = Rails.root + "farmaci.csv"
		# Open the file with all drugs name
		# Search on every line, if it finds the term searched it puts that in an array
		# Return array in json format
		if File.exist?(path)
			File.foreach(path, "\n") do |row|
				# Remove the line feed at the end of the row
				row = row.chomp
				if row =~ /#{name}/i 
					drugs.push(row)
				end
			end
		else
			puts "File non esistente"
		end
		drugs.to_json
	end

end
