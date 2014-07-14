class BacklogController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.backlog.nil?
      Backlog.create(user_id: current_user.id)
    end
  end

  def add_entry 
    puts "START PARAMs"
    puts params
    puts "END PARAMS"
    current_user.backlog.add_entry!(params[:id], current_user.backlog.id)
    render nothing: true
  end

  def delete_entry
    current_user.backlog.remove_entry!(params[:id])
    render nothing: true
  end
end
