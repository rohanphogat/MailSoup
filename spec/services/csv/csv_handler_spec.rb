require 'rails_helper'

RSpec.describe Csv::CsvHandler, type: :service do
	describe 'write to csv file' do
		it 'should write to csv file' do
			mocked_writer = spy('csv writer')
			expect(CSV).to receive(:open).with("path/file.csv",'w').and_yield(mocked_writer)
			values = ['ip','recipient','subject','event']
			Csv::CsvHandler.new("path/","file.csv").write_to_file(values)
		end
	end
end