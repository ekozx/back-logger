class SearchController < ApplicationController
  def index
    Entry.reindex
  end
  def query
    @results = Entry.search params[:query]
    @results.each do |result|
      logger.debug(result)
    end
    if @results.blank? && @results.count > 0
      render nothing: true
    else
      render json: @results
    end
  end
end
