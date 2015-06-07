class EntriesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  #TODO: ADD METHOD COMMENTS!! My code base is getting to large to remember exactly every method lol
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

  #TODO: Export this shit to the model!
  def add
    entry_id = params[:id].to_i
    association_exists = true
    logger = Logger.new('log/development.log')

    if (Entry.pluck(:id).include?(entry_id) && (!(current_user.backlog.entries.pluck(:id).include?(entry_id))))
      Entry.find(entry_id).add_entry!(current_user.backlog.id, entry_id)
      association_exists = false
    end

    if params[:append].blank?
      render nothing: true
    else
      if association_exists
        render json: {}
      else
        entry = Entry.find(params[:id])
        entry.update_photo
        logger.debug(Entry.find(params[:id]))
        render json: entry
      end
    end
  end

  def destroy
    entry_id = params[:id]
    if Entry.pluck(:id).include? entry_id.to_i
      Entry.find(params[:id]).remove_entry!(current_user.backlog.id, entry_id)
    end
    render nothing: true
  end

  def show
    @entry = Entry.find(params[:id])
    @entry.update_photo
    @seen = false
  end

  private
  def entry_params
    params.require(:entry).permit(:title, :description, :thumbnail)
  end
end
