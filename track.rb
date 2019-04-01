class Track
	def initialize(file, tag, bpms)
		@file = file
		@tag = tag
		@bpms = bpms
	end

	def artist
		if !@tag.artist
			return "Unknown Artist"
		else
			return self.clean(@tag.artist)
		end
	end

	def album
		if !@tag.album
			return "Unknown Album"
		else
			return self.clean(@tag.album)
		end
	end
			
	def title
		if !@tag.title
			return "Unknown Title [#{self.bpm}]"
		else
			return "#{self.clean(@tag.title)} [#{self.bpm}]"
		end
	end

	def directory
		return "Artists/#{self.artist}/#{self.album}"
	end

	def full_path
		return "#{self.directory}/#{self.title}.mp3"
	end

	def bpm
		# get bpm from generated bpms supplied in initialize
		matches = @bpms.select { |line| line[/#{@file}/i] }
		first_match = matches[0]

		if (first_match)
			first_match_array = first_match.split('||')
			return first_match_array[1]
		else 
			return 0
		end
	end
	
	def clean(text)
		return text.gsub!(/[^0-9A-Za-z. \-]/, '_')
	end
end
