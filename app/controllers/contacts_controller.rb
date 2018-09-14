class ContactsController < ApplicationController
	add_index :contacts, [:user_id], unique: true

	def create 
		@user = User.find(params[:user_id])
		@contact = @user.contacts.create(contact_params)
		redirect_to user_path(@user)
	end

	private 
		def contact_params 
			params.require(:contact).permit(:name, :email)
		end
end
