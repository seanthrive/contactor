class UsersController < ApplicationController
	before_action :authenticate_user!
  before_action :load_user, except: [:index, :new, :create]

	def show
		@user = User.find(params[:id])
	end

	def new 
	end

	def create
		# Render the request params as plain text.
		# render plain: params[:user].inspect

		@user = User.new(user_params)

		@user.save
		redirect_to @user
	end

	def update
		uploaded_io = params[:user][:contacts_file]
		File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
			file.write(uploaded_io.read)
    end
	end

	private 
    def load_user
      @user = User.find(params[:id])
    end

		def user_params
			params.require(:user).permit(:username, :password)
		end

end
