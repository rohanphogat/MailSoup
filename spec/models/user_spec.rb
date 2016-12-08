require 'rails_helper'

RSpec.describe User, type: :model do

	describe 'email validation' do
		it 'should not create user with invalid email' do
			User.create(email_id:'abcd')
			expect(User.count).to eq(0)
		end
		it 'should create user with valid email' do
			User.create(email_id:'abc@xyz.com')
			expect(User.count).to eq(1)
		end
	end
end
