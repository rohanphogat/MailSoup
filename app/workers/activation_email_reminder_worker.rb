class ActivationEmailReminderWorker
	include Sidekiq::Worker

	def perform(user_id)
		user = User.find_by_id(user_id)
		EmailService.new(user).send_reminder_mail if user.present?
	end

end