class SuggestionsController < ApplicationController
  # include KMeans
  def index
  end

  #TODO this is literally a c/p from search_controller without a check, move it over
  def rt_react_search
    uri = URI("http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=" +
    ENV["ROTTEN_TOMATOES_KEY"] +
    "&q=" +
    params[:query].to_s.gsub(" ", "+") +
    "&page_limit=5&page=1")

    render json: Net::HTTP.get_response(uri).body
  end

  def rt_alias_suggestion
    render json: "rt_alias_suggestion".to_json
  end

  # uses this following endpoint:
  # http://api.rottentomatoes.com/api/public/v1.0/movies/770672122/similar.json?apikey=[your_api_key]&limit=1
  def rt_suggestion
    url = "http://api.rottentomatoes.com/api/public/v1.0/movies/"
    url += params[:id]
    url += "/similar.json?apikey="
    url += ENV['ROTTEN_TOMATOES_KEY']
    url += "&limit=5"
    uri = URI(url)

    render json: Net::HTTP.get_response(uri).body
  end

  ##############################################################################
  ##      Outline for future K-means implementation.                          ##
  ##############################################################################

  # TODO: messed this up, clusterer will need a user, not entries.
  # From selecting 'movies similar to' or 'genre suggestions', or 'more suggestions'
  def more_suggestions
    # if(!params[:genre].blank?) # Here they want more generic suggestions
    #   their_movies = current_user.backlog.entries.where(genre: params[:genre])
    #   if their_movies.count > 4 # If they have enough movies for a sample space, 5 is a magic num thus far
    #     @suggested_entries = get_suggestions(their_movies, 5)
    #   else # Use a random movie of this genre
    #     their_movies << Entry.where(genre: params[:genre]).limit(5 - their_movies.count)
    #     @suggested_entries = get_suggestions(their_movies, 10)
    #   end
    # elsif(!params[:movie_id].blank?) # Here they want something similar to a specific movie
    #   @suggested_entries = get_suggestions(Entry.find(params[:movie_id]), 10)
    # else # blanket case, they just want more suggestions
    #   # handle case when user has no entries
    #   @suggested_entries = get_suggestions(10)
    # end

    render json: @suggested_entries
  end
  # TODO: Need to add Sidekiq worker for background processing the spreadsheet on ajax
  def get_suggestions(number) #including number if I want to specify the amount they can get later
    # append the user and the users entries to the proper spreadsheets
    # run k-means on that data
    # remove the users ratings from the list
  end
end
