class User < ActiveRecord::Base

	EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

	validates :email_id, format: {with: EMAIL_FORMAT, message: "invalid email id"}

end
