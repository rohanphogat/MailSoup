class MailgunController < ApplicationController

	def webhook_stats
		user = User.find_by_email_id(params.require(:recipient))
		email = EmailService.new(user).past_emails(params.require(:tag))
		subject = email.present? ? email['headers']['subject']:""
		Csv::CsvHandler.new("tmp/","webhook_data.csv").write_to_file([params.require(:ip),params[:recipient],subject,params.require(:event)])
		head :ok
	end

end