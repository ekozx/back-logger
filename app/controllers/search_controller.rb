class SearchController < ApplicationController
  def index
    Entry.reindex
  end
  def search
    @results = Entry.search "anime"
  end
end
