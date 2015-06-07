class ZapsController < ApplicationController
  before_action :authenticate_user!

  def index
    potential_zaps = Zap.where(receiver_id: current_user.id)
    @has_zaps = potential_zaps.count > 0
    if @has_zaps
      @zaps = potential_zaps
    else
      @zaps = []
    end
  end

  def created
    @has_zaps = false
    potential_zaps = Zap.where(creator_id: current_user.id)
    @has_zaps = potential_zaps.count > 0
    if @has_zaps
      @zaps = potential_zaps
    else
      @zaps = []
    end
    render "index"
  end

  def new
    @suggested_entries = current_user.backlog.entries.limit(3)
    @suggested_followers = current_user.followers.limit(3)
    @entries = "entries"
    @users = "users"
  end

  def create
    @zap = Zap.new
    @zap.seen = false
    @zap.creator_id = current_user.id
    puts "PARAMS"
    puts params["receiver_id"]
    @zap.message = params["zap"]["message"]
    # @zap.title = params["zap"]["title"]
    @zap.entry_id = params["entry_id"].to_i
    @zap.title = Entry.find(params["entry_id"].to_i).title
    @zap.receiver_id = params["receiver_id"].to_i
    if @zap.save
      puts @zap.id.to_s
      redirect_to "/zaps/" + @zap.id.to_s
    else
      render 'zaps/new'
    end
  end

  def show
    @zap = Zap.find(params[:id])
    @zap.update(seen: true)
    @entry = @zap.entry
    @creator = User.find(@zap.creator_id)
    @receivor = User.find(@zap.receiver_id)
  end
end
