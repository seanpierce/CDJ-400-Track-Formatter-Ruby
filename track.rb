class Track
	def initialize(tag)
		@tag = tag
	end

	def artist
		if !@tag.artist
			return "Unknown Artist"
		else
			if @tag.artist.include? "/"
				return @tag.artist.gsub("/", "_")
			else
				return @tag.artist
			end
		end
	end

	def album
		if !@tag.album
			return "Unknown Album"
		else
			if @tag.album.include? "/"
				return @tag.album.gsub("/", "_")
			else
				return @tag.album
			end
		end
	end
			
	def title
		if !@tag.title
			return "Unknown Title [#{self.bpm}]"
		else
			if @tag.title.include? "/"
				return "#{@tag.title.gsub("/", "_")} [#{self.bpm}]"
			else
				return "#{@tag.title} [#{self.bpm}]"
			end
		end
	end

	def directory
		return "Artists/#{self.artist}/#{self.album}"
	end

	def full_path
		return "#{self.directory}/#{self.title}.mp3"
	end

	def bpm
		if (@tag.get_frame(:TBPM))
			# if file already has BPM tag
			return @tag.get_frame(:TBPM).content
		else
			# get bpm frm generated bpms
			bpms = File.readlines('bpms.txt')
			matches = bpms.select { |name| name[/#{self.title}/i] }
			first_match = matches[0]

			if (first_match)
				first_match_array = first_match.split('||')
				return first_match_array[1]
			else 
				return 0
			end
		end
	end
end