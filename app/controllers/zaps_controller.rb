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

  def created_zaps
  end
end
