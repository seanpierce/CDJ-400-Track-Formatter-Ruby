require 'id3tag'
require 'fileutils'
require 'shellwords'

require_relative 'track'

mp3s = Dir.entries("./").select { |filename| filename =~ /\.mp3/i }

def make_symlink(file, track)
	escaped_file = Shellwords.shellescape file
	escaped_destination = Shellwords.shellescape "./#{track.full_path}"

	symlink = system "ln -s \"$(realpath Tracks/#{escaped_file})\" #{escaped_destination}"

	if !symlink
		puts "Unable to create symlink for #{track.title}"
	end
end

mp3s.each do |file|
	begin
		ID3Tag.read(File.open(file, "rb")) do |tag|
			track = Track.new(tag)
			
			FileUtils.mkdir_p "Tracks"
			FileUtils.mkdir_p track.directory
			
			FileUtils.mv file, "Tracks/#{file}"
			make_symlink(file, track)
		end
	rescue StandardError => e
		puts "An error occurred: #{e.message}"
	ensure
		next
	end
end