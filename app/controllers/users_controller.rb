class UsersController < ApplicationController

	def activate
		render text: "Thank you for activating your account"
	end

	def index
		@users = User.all
	end

	def new
		@user = User.new
	end

	def create
		@user = User.create(params[:user].permit(:name,:email_id))
		if @user.errors.any?
			render :new
		else
			redirect_url = "#{request.protocol}#{request.host_with_port}#{request.fullpath}"
			EmailService.new(@user).send_activation_email(redirect_url)
			EmailService.new(@user).send_reminder_mail
			# ActivationEmailReminderWorker.perform_in(15.seconds.from_now,@user.id)
			redirect_to users_path
		end
	end

end