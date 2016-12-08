module Mailgun
  class Suppressions < APIClient

  	def initialize(suppression_type)
  		@supp_type = suppression_type
  	end

  	def check_suppression_status(email_id)
  		response = execute_request(:get, base_url+"/#{email_id}")
  		if response.code == 200
  			return true
  		end
  		return false
  	end

  	def base_url
  		supp_type_url = EmailContentHelper.getSuppressionType(@supp_type)
  		return super + "/#{supp_type_url}"
  	end

  end
end