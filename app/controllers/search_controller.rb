class SearchController < ApplicationController
  def index
    @results = Entry.search "anime"
  end
end
