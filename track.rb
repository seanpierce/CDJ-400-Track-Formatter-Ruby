class Track
	def initialize(tag)
		@tag = tag
	end

	def artist
		if !@tag.artist
			return "Unknown"
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
			return "Unknown"
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
			return "Unknown"
		else
			if @tag.title.include? "/"
				return @tag.title.gsub("/", "_")
			else
				return @tag.title
			end
		end
	end

	def bpm
		if !@tag.bpm
			return 0
		else
			return @tag.bpm
		end
	end

	def full_bpm_path
		return "#{self.bpm}_#{self.artist}-#{self.title}.mp3"
	end

	def directory
		return "Artists/#{self.artist}/#{self.album}"
	end

	def full_path
		return "#{self.directory}/#{self.title}.mp3"
	end
end