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
			return "Unknown Title"
		else
			if @tag.title.include? "/" 
				return @tag.title.gsub("/", "_") 
			else 
				return @tag.title 
			end
		end
	end
end