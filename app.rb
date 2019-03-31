require "id3tag"
require 'fileutils'

require_relative 'track'

mp3s = Dir.entries("./").select { |filename| filename =~ /\.mp3/i }

mp3s.each do |file|

	begin
		ID3Tag.read(File.open(file, "rb")) do |tag|
			track = Track.new(tag)
			FileUtils.mkdir_p "Artists/#{track.artist}"
			FileUtils.mv(file, "Artists/#{track.artist}/#{track.title}.mp3")
		end
	rescue StandardError => e
		puts "An error occurred: #{e.message}"
	ensure
		next
	end
end