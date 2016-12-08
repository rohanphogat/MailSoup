require 'rails_helper'

RSpec.describe Mailgun::Events, type: :service do
	describe 'check open mails' do
		let(:mocked_user) { spy('User', name: 'username', email_id:'usermail') }
		it 'should return false when items key not present in response' do
			expect(Rails.application.secrets).to receive(:mailgun_key).and_return('key')
			mocked_response = spy('response')
  		expect(HTTParty).to receive(:get).and_return(mocked_response)
  		expect(mocked_response).to receive(:parsed_response).and_return("some data")
			expect(Mailgun::Events.new(:OPENED).check_email_open(mocked_user.email_id)).to eq(false)
		end

		it 'should return false when items empty' do
			expect(Rails.application.secrets).to receive(:mailgun_key).and_return('key')
			mocked_response = spy('response')
  		expect(HTTParty).to receive(:get).and_return(mocked_response)
  		response_hash = {'items'=>[]}
  		expect(mocked_response).to receive(:parsed_response).and_return(response_hash)
			expect(Mailgun::Events.new(:OPENED).check_email_open(mocked_user.email_id)).to eq(false)
		end

		it 'should return false when success and has event' do
			expect(Rails.application.secrets).to receive(:mailgun_key).and_return('key')
			mocked_response = spy('response')
  		expect(HTTParty).to receive(:get).and_return(mocked_response)
  		response_hash = {'items'=>['some data']}
  		expect(mocked_response).to receive(:parsed_response).and_return(response_hash)
			expect(Mailgun::Events.new(:OPENED).check_email_open(mocked_user.email_id)).to eq(true)
		end
	end
	describe 'get past mails' do
		let(:mocked_user) { spy('User', name: 'username', email_id:'usermail') }
		it 'should return nil when items missing from response' do
			expect(Rails.application.secrets).to receive(:mailgun_key).and_return('key')
			mocked_response = spy('response')
  		expect(HTTParty).to receive(:get).and_return(mocked_response)
  		expect(mocked_response).to receive(:parsed_response).and_return("some data")
			expect(Mailgun::Events.new(:ACCEPTED).get_past_mail(mocked_user.email_id,'tag')).to eq(nil)
		end
		it 'should return nil when items empty in response' do
			expect(Rails.application.secrets).to receive(:mailgun_key).and_return('key')
			mocked_response = spy('response')
  		expect(HTTParty).to receive(:get).and_return(mocked_response)
  		response_hash = {'items'=>[]}
  		expect(mocked_response).to receive(:parsed_response).and_return(response_hash)
			expect(Mailgun::Events.new(:ACCEPTED).get_past_mail(mocked_user.email_id,'tag')).to eq(nil)
		end
		it 'should return message data when items present in response' do
			expect(Rails.application.secrets).to receive(:mailgun_key).and_return('key')
			mocked_response = spy('response')
  		expect(HTTParty).to receive(:get).and_return(mocked_response)
  		response_hash = {'items'=>[{'message'=>'data'}]}
  		expect(mocked_response).to receive(:parsed_response).and_return(response_hash)
			expect(Mailgun::Events.new(:ACCEPTED).get_past_mail(mocked_user.email_id,'tag')).to eq('data')
		end
	end
end