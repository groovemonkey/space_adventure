# Code_Counter v.0.0.0.01
# count LOC in a project

# (I don't think this will include files in the current directory; only further down the tree)
# NOT IMPLEMENTED -- eliminating whitespace and comments

filenames = Dir["./**/*.rb"]
total_lines = 0

filenames.each do |fname|

	filecounter = 0
	File.new(fname, "r").each do |line|
		filecounter += 1
	end

	puts "#{filecounter} lines in #{fname}"
	total_lines += filecounter
end

puts "\n\n #{total_lines} Total Lines of Code"