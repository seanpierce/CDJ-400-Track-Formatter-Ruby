require 'id3tag'
require 'fileutils'

require_relative 'functions'

puts "======"
puts "[1] Collect BPM for all trackos"
puts "[2] Sort by Artist"
puts "[3] Sort by BPM"
process = gets

if process.to_i == 1
	get_bpms()
elsif process.to_i == 2
	sort_by_artist()
else 
	sort_by_bpm()
end

