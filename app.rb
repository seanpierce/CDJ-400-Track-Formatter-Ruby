require "id3tag"
require 'fileutils'

mp3s = Dir.entries("./").select { |filename| filename =~ /\.mp3/i }

mp3s.each do |file|
	ID3Tag.read(File.open(file, "rb")) do |tag|

		artist = tag.artist
		title = tag.title
		FileUtils.mkdir_p artist
		FileUtils.mv(file, "#{artist}/#{title}.mp3")
	end
end