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
          entry = false
          #query rotten tomatoes
          uri = URI("http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=" +
          ENV["ROTTEN_TOMATOES_KEY"] + "&q=" + query.to_s.gsub(" ", "+") + "&page_limit=1")
          resp = JSON.parse(Net::HTTP.get_response(uri).body)
          unless resp.blank?
            #add each resp to the database
            resp["movies"].each do |movie|
              entry = Entry.create(title: movie["title"], description: movie["synopsis"])
            end
            #there's certainly a better way of doing this...
            @results = Entry.search query
          end
        end
      end
    else
      @results = User.search query
    end

    if @results.blank? && @results.count > 0
      render nothing: true
    else
      # if has_entry then render json: @results else render json: @results.to_a.push(entry).to_json end
      render json: @results
    end
  end
end
