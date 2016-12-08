require 'rails_helper'

RSpec.describe Mailgun::Events, type: :service do
	describe 'check suppression list' do
		let(:mocked_user) { spy('User', name: 'username', email_id:'usermail') }
		it 'should return false when email not in bounce list' do
			expect(Rails.application.secrets).to receive(:mailgun_key).and_return('key')
			mocked_response = spy('response')
  		expect(HTTParty).to receive(:get).and_return(mocked_response)
  		expect(mocked_response).to receive(:code).and_return(404)
			expect(Mailgun::Suppressions.new(:BOUNCE).check_suppression_status(mocked_user.email_id)).to eq(false)
		end

		it 'should return true when email in bounce list' do
			expect(Rails.application.secrets).to receive(:mailgun_key).and_return('key')
			mocked_response = spy('response')
  		expect(HTTParty).to receive(:get).and_return(mocked_response)
  		expect(mocked_response).to receive(:code).and_return(200)
			expect(Mailgun::Suppressions.new(:BOUNCE).check_suppression_status(mocked_user.email_id)).to eq(true)
		end

		it 'should return false when email not in unusbscribe list' do
			expect(Rails.application.secrets).to receive(:mailgun_key).and_return('key')
			mocked_response = spy('response')
  		expect(HTTParty).to receive(:get).and_return(mocked_response)
  		expect(mocked_response).to receive(:code).and_return(404)
			expect(Mailgun::Suppressions.new(:UNSUBSCRIBE).check_suppression_status(mocked_user.email_id)).to eq(false)
		end

		it 'should return true when email in unsubscribe list' do
			expect(Rails.application.secrets).to receive(:mailgun_key).and_return('key')
			mocked_response = spy('response')
  		expect(HTTParty).to receive(:get).and_return(mocked_response)
  		expect(mocked_response).to receive(:code).and_return(200)
			expect(Mailgun::Suppressions.new(:UNSUBSCRIBE).check_suppression_status(mocked_user.email_id)).to eq(true)
		end
		it 'should return false when email not in complaint list' do
			expect(Rails.application.secrets).to receive(:mailgun_key).and_return('key')
			mocked_response = spy('response')
  		expect(HTTParty).to receive(:get).and_return(mocked_response)
  		expect(mocked_response).to receive(:code).and_return(404)
			expect(Mailgun::Suppressions.new(:COMPLAINT).check_suppression_status(mocked_user.email_id)).to eq(false)
		end

		it 'should return true when email in complaint list' do
			expect(Rails.application.secrets).to receive(:mailgun_key).and_return('key')
			mocked_response = spy('response')
  		expect(HTTParty).to receive(:get).and_return(mocked_response)
  		expect(mocked_response).to receive(:code).and_return(200)
			expect(Mailgun::Suppressions.new(:COMPLAINT).check_suppression_status(mocked_user.email_id)).to eq(true)
		end
	end
end