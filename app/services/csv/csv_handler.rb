require 'csv'
module Csv
	class CsvHandler

		def initialize(file_path,file_name)
			@file = file_path + file_name
		end

		def write_to_file(values)
			CSV.open( @file, 'w' ) do |writer|
	    		writer << values
			end
		end
	end
end