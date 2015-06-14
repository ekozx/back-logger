class SuggestionsController < ApplicationController
  def index
    @suggested_entries = get_suggestions(current_user, 10)
  end

  # From selecting 'movies similar to' or 'genre suggestions', or 'more suggestions'
  def more_suggestions
    @suggested_entries = []

    if(!params[:genre].blank?) # Here they want more generic suggestions
      their_movies = current_user.backlog.entries.where(genre: params[:genre])
      if their_movies.count > 0 # If they have enough movies for a sample space, 10 is a magic num thus far
        sample_movie = their_movies.offset(rand(their_movies.count)).first # Use one they they like of this genre
        @suggested_entries = get_suggestions(sample_movie, 10)
      else # Use a random movie of this genre
        sample_movies = Entry.where(genre: params[:genre])
        sample_movie = sample_movies.offset(rand(sample_movies.count)).first
        @suggested_entries = get_suggestions(sample_movie, 10)
      end
    elsif(!params[:movie_id].blank?) # Here they want something similar to a specific movie
      @suggested_entries = get_suggestions(Entry.find(params[:movie_id]), 10)
    else # blanket case, they just want more suggestions
      @suggested_entries = get_suggestions(current_user.backlog.entries, 10)
    end

    render json: @suggested_entries
  end

  def get_suggestions(model, number) #including number if I want to specify the amount they can get later
    return Entry.offset(rand(Entry.count)).limit(number) #dummy for now
  end
end
