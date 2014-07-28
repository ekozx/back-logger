class BacklogController < ApplicationController
  before_action :authenticate_user!

  def index
    @entries = current_user.backlog.entries.page(params[:page]).per(10)

    if current_user.backlog.nil?
      Backlog.create(user_id: current_user.id)
    end
  end

  def unbuilt
    entry = Entry.create(title: params[:title], description: params[:description], imdb_id: params[:imdb_id])
    entry.update_photo
    render entry_path(entry.id)
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
