require 'rails_helper'

RSpec.describe MailgunController, type: :controller do

	describe 'post #webhook_stats' do
		it 'should return success' do
			mocked_user = spy('User',email_id: 'abc@test.com')
			expect(User).to receive(:find_by_email_id).with('abc@test.com').and_return(mocked_user)
			email_message = {'headers'=>{'subject'=>'subject_title'}}
			expect(EmailService).to receive_message_chain(:new,:past_emails).with(mocked_user).with('tag').and_return(email_message)
			expect(Csv::CsvHandler).to receive_message_chain(:new,:write_to_file).with("tmp/","webhook_data.csv").with(['ip','abc@test.com','subject_title','event'])
			post :webhook_stats, {ip: 'ip', recipient: 'abc@test.com', tag:'tag', event: 'event'}
			expect(response.code).to eq('200')
		end

	end	
end