class SearchController < ApplicationController
  def index
    Entry.reindex
  end
  def query
    @results = Entry.search params[:query]
    if @results.blank?
      render nothing: true
    else
      render json: @results
    end
  end
end
