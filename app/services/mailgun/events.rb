module Mailgun
  class Events < APIClient

  	def initialize(event_type)
  		@event_type = EmailContentHelper.getEventType(event_type)
  	end

  	def check_email_open(email_id)
  		params = check_email_open_params(email_id)
  		response = execute_request(:get,base_url,params)
      items = response.parsed_response['items'] rescue nil
  		if items.present?
	  		return !items.empty?
	  	end
	  	return false
  	end


  	def get_past_mail(email_id,tag)
  		params = past_email_params(email_id,tag)
  		response = execute_request(:get,base_url,params)
  		items = response.parsed_response['items'] rescue nil
  		if items.present?
	  		return items.last['message']
	  	end
	  	return nil
  	end

  	def base_url
  		return super + "/events"
  	end

  	private

  	def check_email_open_params(email_id)
  		params = Hash.new
  		params['recipient']=email_id
  		params['event']=@event_type
  		return params
  	end

  	def past_email_params(email_id,tag)
  		params = Hash.new
  		params['recipient'] = email_id
  		params['tag'] = tag
  		params['event']=@event_type
      params['ascending']='yes'
  		return params
  	end

  end
end