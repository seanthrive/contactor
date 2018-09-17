class ContactsController < ApplicationController
  before_action :load_user, only: [:create]

  def create
    @contact = @user.contacts.create(contact_params)
    flash[:notice] = "Successfully created contact"
    redirect_to user_path(@user)
  end

  private
  def load_user
    @user = User.find(params[:user_id])
  end

  def contact_params
    params.require(:contact).permit(:name, :email)
  end
end
