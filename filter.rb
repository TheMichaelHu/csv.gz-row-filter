#!/usr/bin/env ruby
require 'zlib'
require 'fileutils'
require 'tempfile'

# Removes lines that don't match this regex anywhere
$FILTER_REGEX = /^(?!19).*/

def main
	path = File.expand_path(ARGV[0])

	if File.file?(path)
		filter(path) if path =~ /\.csv.gz$/
	elsif File.directory?(path)
		Dir.glob(path+"/**/*.csv.gz").each { |gz|
			filter(gz)
		}
	else
		puts "#{path}: No such file or directory"
	end
end

def filter(gz)
	tmp = Tempfile.new('temp')
	matched = false

	Zlib::GzipReader.open(gz) { |csv|
		csv.each_line { |line|
			if line =~ $FILTER_REGEX
				tmp.write(line)
			else
				matched = true
			end
		}
	}
	tmp.close

	if matched
		Zlib::GzipWriter.open(gz) { |filtered|
		 File.readlines(tmp.path).each { |line|
		  filtered.write(line)
		 }
		 filtered.close
		}
		puts "Removed line(s) from #{gz}"
	end

	tmp.delete
end

main