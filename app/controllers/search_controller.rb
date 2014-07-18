class SearchController < ApplicationController
  def index
  end
  def query
    @results = Entry.search params[:query]
    if @results.blank? && @results.count > 0
      render nothing: true
    else
      render json: @results
    end
  end
end
