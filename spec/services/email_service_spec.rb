require 'rails_helper'

RSpec.describe EmailService, type: :service do
	describe 'Email Service tests' do
		let(:mocked_user) { spy('User', name: 'username', email_id:'usermail') }

		it 'sends activation mail' do
			expect(Mailgun::Messages).to receive_message_chain(:new,:send_mail).with(:ACTIVATION).with('usermail',{'text_vars'=>['username','redirect_url']})
			EmailService.new(mocked_user).send_activation_email('redirect_url')
		end

		it 'get past mails' do
			expect(Mailgun::Events).to receive_message_chain(:new,:get_past_mail).with(:ACCEPTED).with('usermail','tag')
			EmailService.new(mocked_user).past_emails('tag')
		end
		it 'send reminder mail when user has not opened mail and isnt in suppression list' do
			allow(Mailgun::Suppressions).to receive_message_chain(:new,:check_suppression_status).with(any_args).with('usermail').and_return(false)
			expect(Mailgun::Events).to receive_message_chain(:new,:check_email_open).with(:OPENED).with('usermail').and_return(false)
			expect(Mailgun::Messages).to receive_message_chain(:new,:send_mail).with(:ACTIVATION_REMINDER).with('usermail',{'text_vars'=>['username']})
			EmailService.new(mocked_user).send_reminder_mail
		end
		it 'not send reminder mail when user has opened mail and isnt in suppression list' do
			allow(Mailgun::Suppressions).to receive_message_chain(:new,:check_suppression_status).with(any_args).with('usermail').and_return(false)
			expect(Mailgun::Events).to receive_message_chain(:new,:check_email_open).with(:OPENED).with('usermail').and_return(true)
			expect(Mailgun::Messages).to_not receive(:new)
			EmailService.new(mocked_user).send_reminder_mail
		end
		it 'not send reminder mail when user has not opened mail and is in suppression list' do
			allow(Mailgun::Suppressions).to receive_message_chain(:new,:check_suppression_status).with(any_args).with('usermail').and_return(true)
			expect(Mailgun::Events).to_not receive(:new)
			expect(Mailgun::Messages).to_not receive(:new)
			EmailService.new(mocked_user).send_reminder_mail
		end
	end
end