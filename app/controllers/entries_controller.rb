class EntriesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    logger = Logger.new('log/development.log')
    if @entry.save
      @entry.add_entry!(current_user.backlog.id, @entry.id)
    end
    render nothing: true
  end

  def add
    entry_id = params[:id]
    if Entry.pluck(:id).include? entry_id.to_i then Entry.find(entry_id).add_entry!(current_user.backlog.id, entry_id) end
    render nothing: true
  end

  def destroy
    entry_id = params[:id]
    if Entry.pluck(:id).include? entry_id.to_i then Entry.find(params[:id]).remove_entry!(current_user.backlog.id, entry_id) end
    render nothing: true
  end

  def show
    @entry = Entry.find(params[:id])
    @entry.update_photo
  end

  private
  def entry_params
    params.require(:entry).permit(:title, :description, :thumbnail)
  end
end
