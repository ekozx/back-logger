class SearchController < ApplicationController

  #TODO: Move this stuff to a model?
  def index
    Entry.reindex
    User.reindex
  end
  def query
    if params[:type] == "entries"
      @results = Entry.search params[:query]
    else
      @results = User.search params[:query]
    end

    if @results.blank? && @results.count > 0
      render nothing: true
    else
      render json: @results
    end
  end
end
