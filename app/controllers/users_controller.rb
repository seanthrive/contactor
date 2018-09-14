class UsersController < ApplicationController
	# before_action :authenticate_user!
  before_action :load_user, except: [:index, :new, :create]

  def index 
    @users = {users: User.all}
    render json: @users
  end

	def show
		@user = User.find(params[:id])
    render json: @user, root: true
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

    filepath = Rails.root.join('public', 'uploads', uploaded_io.original_filename)

		File.open(filepath, 'wb') do |file|
			file.write(uploaded_io.read)
    end

    File.foreach(filepath, "BEGIN:VCARD") do |card|
      vcard = VCardigan.parse(card)

      unless vcard.fn.nil? || vcard.tel.nil?
        contact_params = { name: vcard.fn[0].values[0], email: vcard.tel[0].values[0] }
        @user.contacts.create(contact_params)
      end

    end

    redirect_to @user
	end

	private 
    def load_user
      @user = User.find(params[:id])
    end

		def user_params
			params.require(:user).permit(:username, :password)
		end

end
