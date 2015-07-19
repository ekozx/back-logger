class SuggestionsController < ApplicationController
  # include KMeans
  def index
    # @suggested_entries = get_suggestions(10)
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
