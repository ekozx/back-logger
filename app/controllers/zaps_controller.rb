class ZapsController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.zaps.nil?
      @zaps = []
    else
      @zaps = current_user.zaps
    end
  end
end
