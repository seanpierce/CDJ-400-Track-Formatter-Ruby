require "id3tag"
require 'fileutils'

mp3s = Dir.entries("./").select { |filename| filename =~ /\.mp3/i }

mp3s.each do |file|

	begin
		ID3Tag.read(File.open(file, "rb")) do |tag|
			FileUtils.mkdir_p tag.artist
			FileUtils.mv(file, "#{tag.artist}/#{tag.title}.mp3")
		end
	rescue StandardError => e
		puts "An error occurred: #{e.message}"
	ensure
		next
	end
end