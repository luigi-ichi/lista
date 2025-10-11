class MainController < ApplicationController
  def index
    if user_signed_in?
      # Set up data for logged-in users
      # You can add more user-specific data here later

      if current_user.lists.present?
        redirect_to lists_path
        return
      end

      @user = current_user
    else
      # Set up data for guest users
      # You can add guest-specific data here later
    end
  end
end
