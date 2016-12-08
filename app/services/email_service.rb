class EmailService

	def initialize(user=nil)
		@user = user
	end

	def send_activation_email(redirect_url)
		options_hash = {'text_vars'=>[@user.name,redirect_url]}
		Mailgun::Messages.new(:ACTIVATION).send_mail(@user.email_id,options_hash)
	end

	def past_emails(tag)
		Mailgun::Events.new(:ACCEPTED).get_past_mail(@user.email_id,tag)
	end

	def send_reminder_mail
		if(!supression_check && !open_mail_check)
			options_hash = {'text_vars'=>[@user.name]}
			Mailgun::Messages.new(:ACTIVATION_REMINDER).send_mail(@user.email_id,options_hash)
		end
	end

	private

	def supression_check
		return(Mailgun::Suppressions.new(:BOUNCE).check_suppression_status(@user.email_id) ||
		Mailgun::Suppressions.new(:UNSUBSCRIBE).check_suppression_status(@user.email_id) ||
		Mailgun::Suppressions.new(:COMPLAINT).check_suppression_status(@user.email_id))
	end

	def open_mail_check
		Mailgun::Events.new(:OPENED).check_email_open(@user.email_id)
	end

end