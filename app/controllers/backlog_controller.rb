class BacklogController < ApplicationController
  before_action :authenticate_user!

  def index
    if current_user.backlog.nil?
      Backlog.create(user_id: current_user.id)
    end

    @entries = current_user.backlog.entries.reorder("associations.created_at DESC").page(params[:page]).per(10)
  end

  def unbuilt
    logger = Logger.new('log/development.log')
    logger.debug("PARAMS:")
    logger.debug(params["movie_info"])
    # logger.debug(params["movie_info"][0])
    title = params["movie_info"][0]
    # logger.debug(params["movie_info"][1])
    description = params["movie_info"][1]
    logger.debug(params["movie_info"][2])
    imdb = params["movie_info"][2]
    thumb = params["movie_info"][3]
    if Entry.exists?(title: title, description: description)
      entry = Entry.where(title: title, description: description).take
    else
      entry = Entry.create(title: title, description: description, imdb_id: imdb, thumbnail_file_name: thumb)
    end
    entry.update_photo
    logger.debug("ID:")
    logger.debug(entry)
    # redirect_to '/entries/' + entry.id.to_s
    render json: entry
  end

  #TODO: See if these methods actually do something... Might have been part of the earlier version
  # def add_entry
  #   current_user.backlog.add_entry!(params[:id], current_user.backlog.id)
  #   render nothing: true
  # end
  #
  # def delete_entry
  #   current_user.backlog.remove_entry!(params[:id])
  #   render nothing: true
  # end
end
