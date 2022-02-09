class UsersController < ApplicationController
  before_action :authorize, only: [:show]
  def create
    user = User.create(user_params)
    if user.valid?
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    current_user = User.find(session[:user_id])
    render json: current_user
  end

  private

  def authorize
    render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
  end

  def user_params
    params.permit(:username, :password, :password_confirmation, :image_url, :bio)
  end
end