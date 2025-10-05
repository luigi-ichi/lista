class MainController < ApplicationController
  def index
    if user_signed_in?
      # Set up data for logged-in users
      @user = current_user
      # You can add more user-specific data here later
    else
      # Set up data for guest users
      # You can add guest-specific data here later
    end
  end
end
