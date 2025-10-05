class PasswordsController < ApplicationController
  before_action :authenticate_user!

  def edit
    # Render password form here
  end

  def update
    if current_user.update(password_params)
      redirect_to edit_password_path, notice: "Password updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def password_params
    # params.expect(user: [:password, :password_confirmation, :password_challenge]).with_defaults(password_challenge: "")
    params.require(:user).permit(:password, :password_confirmation, :password_challenge).with_defaults(password_challenge: "")
  end
end
