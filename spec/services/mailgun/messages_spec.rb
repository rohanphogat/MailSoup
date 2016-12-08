require 'rails_helper'

RSpec.describe Mailgun::Messages, type: :service do
	describe 'send mails' do
		let(:mocked_user) { spy('User', name: 'username', email_id:'usermail') }
		it 'should send activation mail' do
			expect(Rails.application.secrets).to receive(:mailgun_key).and_return('key')
  		expect(HTTParty).to receive(:post).and_return('mocked_response')
  		options_hash = {'text_vars'=>['username','link']}
			Mailgun::Messages.new(:ACTIVATION).send_mail(mocked_user.email_id,options_hash)
		end

		it 'should send activation reminder mail' do
			expect(Rails.application.secrets).to receive(:mailgun_key).and_return('key')
  		expect(HTTParty).to receive(:post).and_return('mocked_response')
  		options_hash = {'text_vars'=>['username']}
			Mailgun::Messages.new(:ACTIVATION_REMINDER).send_mail(mocked_user.email_id,options_hash)
		end
	end
end