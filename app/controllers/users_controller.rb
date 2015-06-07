class UsersController < ApplicationController
  def followers
    @followers = current_user.followers
  end
  def following
    @followed_users = current_user.followed_users
    @group = "users"
  end
  def show
    @user = User.find(params[:id])
    @user_backlog = @user.backlog
    @group = 'entries'
    # @results = @user_backlog.entries.page(params[:page]).per(10)
    @results = @user_backlog.entries
  end
  def follow
    current_user.follow!(params[:id], current_user.id)
    render json: User.find(params[:id])
  end
  def unfollow
    puts params["id"]
    current_user.unfollow!(params[:id], current_user.id)
    render nothing: true
  end
  def rating
    uid = current_user.id
    eid = params[:id]
    new_rating = params[:rating]
    ratings_relation = Rating.where(user_id: uid, entry_id: eid)
    rating_exists = ratings_relation.count > 0
    if rating_exists
      ratings_relation.take.update(rating: new_rating)
    else
      Rating.create(user_id: uid, entry_id: eid, rating: new_rating)
    end
    render nothing: true
  end

  #Will implement for typed search later
  def has_entry?
  end
end
