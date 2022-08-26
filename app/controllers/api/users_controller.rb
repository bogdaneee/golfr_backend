module Api
  # Controller that handles authorization and user data fetching
  class UsersController < ApplicationController
    include Devise::Controllers::Helpers
    before_action :logged_in!, only: :index
    def login
      user = User.find_by('lower(email) = ?', params[:email])

      if user.blank? || !user.valid_password?(params[:password])
        render json: {
          errors: [
            'Invalid email/password combination'
          ]
        }, status: :unauthorized
        return
      end

      sign_in(:user, user)

      render json: {
        user: {
          id: user.id,
          email: user.email,
          name: user.name,
          token: current_token
        }
      }.to_json
    end

    def index
      user = User.find_by(id: params[:id])

      if user
        render json: {
          id: user.id,
          name: user.name,
          email: user.email
        }.to_json
      else
        render json: {
          errors: [
            "This user doesn't exist!"
          ]
        }, status: :not_found
      end
    end
  end
end
