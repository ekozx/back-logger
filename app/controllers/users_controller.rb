class UsersController < ApplicationController
  def followers
    @followers = current_user.followers
  end
  def following
    @followed_users = current_user.followed_users
  end
  def show
    @user = User.find(params[:id])
    @user_backlog = @user.backlog
  end
  def unfollow
    puts params["id"]
    current_user.unfollow!(params["id"])
    render nothing: true
  end
end
