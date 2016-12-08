module Mailgun
  class Messages < APIClient

  	def initialize(action)
  		@action = action
  	end

  	def send_mail(email_id, options={})
      params = email_params(email_id,options)
      params.merge!(options['extra_params']) if options['extra_params'].present?
  		execute_request(:post, base_url, params)
  	end

  	def base_url
  		return super + "/messages"
  	end

  	private

  	def email_params(email, options)
  		params = Hash.new
  		params[:from] = Settings.mailgun.from_email
  		params[:to] = email
  		params[:subject] = EmailContentHelper.getSubject(@action,options['subject_vars'])
  		params[:text] = EmailContentHelper.getMessage(@action,options['text_vars'])
  		params[:tag] = EmailContentHelper.getTags(@action)
  		return params
  	end

  end
end