class SearchController < ApplicationController

  #TODO: WAY too much logic, move this stuff to a model
  def index
    Entry.reindex
    User.reindex
  end
  def query
    query = params[:query]

    if params[:type] == "entries"
      @results = Entry.search query

      #TODO: Switch this to bisection for speed
      if params[:t] == 'tomatoes'
        has_entry = false
        @results.to_a.each do |result|
          if result.title.downcase.gsub(/\s+/, "") == query.downcase.gsub(/\s+/, "")
            has_entry = true
          end
        end
        #TODO: (in progress) finish this method
        unless has_entry
          #query rotten tomatoes
          uri = URI("http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=3gh3a35gm2x9x3as2qp69rr4&q=" + query + "&page_limit=1")
          resp = JSON.parse(Net::HTTP.get_response(uri).body)
          unless reps.blank?
            #add each resp to the database
            Entry.create(title: , description: )
            #append to results
          end
        end
      end

    else
      @results = User.search query
    end

    if @results.blank? && @results.count > 0
      render nothing: true
    else
      render json: @results
    end
  end
end
