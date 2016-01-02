#!/usr/bin/env ruby
require 'zlib'
require 'fileutils'
require 'tempfile'

path = File.expand_path(ARGV[0])
filter_regex = /^19.*/

Dir.glob(path+"**/*.csv.gz").each { |gz|
	tmp = Tempfile.new('temp')
	Zlib::GzipReader.open(gz) { |csv|
		csv.each_line { |line|
			tmp.write(line) if (line =~ filter_regex).nil?
		}
	}
	tmp.close

	Zlib::GzipWriter.open(gz) { |filtered|
	 File.readlines(tmp.path).each { |line|
	  filtered.write(line)
	 }
	 filtered.close
	}
	tmp.delete
}