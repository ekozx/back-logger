namespace :entries do
  desc 'Entries related tasks'

  def bare s
    return s.gsub(/[-()'*,.]/, "").strip.downcase
  end

  def genre_id_mapping(genres, entry)
    genres.each do |genre|
      # Make sure we have entries for each genre
      genre_record = Genre.where(genre_name: genre).take
      if genre_record == nil
        genre_record = Genre.create(genre_name: genre)
      end
      # Create a genre mapping to remember this specific genre
      unless GenreMapping.where(entry_id: entry.id, genre_id: genre_record.id).count > 0
        GenreMapping.create(entry_id: entry.id, genre_id: genre_record.id)
      end
    end
  end

  # A super quick task to update my old entries with new fields
  # Reuses the HTTP call to rotten tomatoes from search_controller, could be DRY'd up of course
  task fetch_update: :environment do
    call_limit = 400
    call = 0
    if Rails.env == 'development'
      Entry.all.each do |entry|
        if ((entry.rotten_tomatoes_id.blank?) && # lol, this condition could be its own method)
          (call < call_limit) &&
          (!(entry.imdb_id.blank?)))
          puts ("entry with id: " + entry.id.to_s +
          " and imdb id: " + entry.imdb_id.to_s + " needs updated. Call #" + call.to_s)
          # Info call
          uri = URI("http://api.rottentomatoes.com/api/public/v1.0/movie_alias.json?apikey=" +
          ENV["ROTTEN_TOMATOES_KEY"] +
          "&type=imdb" +
          "&id=" + entry.imdb_id.to_s)
          resp = JSON.parse(Net::HTTP.get_response(uri).body)
          puts resp
          # Incrememnt the number of cals to be sure we dont go over
          call += 2
          unless resp.blank?
            entry.update(
              rotten_tomatoes_id: resp['id'],
            )
            unless resp['genres'].blank?
              genre_id_mapping(resp['genres'], entry)
            end
          end
        end
      end
    else
      puts "update entries not available in production"
    end
  end

  # Searching for 2 or more entries with the same title/description
  # but different ids and removing one or more.
  task remove_dups: :environment do
    valid_entry_array_map = [{id: 0, title: "", description: ""}]  # The list of checked entries
    entry_array_map = []        # The list of unchecked entries
    duplicate_ids = []          # Arary of duplicate pairs

    puts "Generate an array of maps of these to use more clearly"
    Entry.pluck(:id, :title, :description).each do |entry|
      entry_hash = {
        id: entry[0],
        title: entry[1],
        description: entry[2]
      }
      entry_array_map.push(entry_hash)

      #small fix for no description entries
      if entry_hash[:description] == "" || entry_hash[:description].strip == "No description"
        #Duplicate entries rollback here!!
        dups = Entry.where('id != ?', entry_hash[:id]).where(
          title: entry_hash[:title]
          )
        if dups.count > 0
          dups.destroy_all
        else
          Entry.find(entry_hash[:id]).update!(description: "No Description")
        end
      end
    end
    puts "entry_array_map:"
    puts entry_array_map
    puts "searching for duplicates"
    entry_array_map.each do |entry|
      # If there is an item in the valid_entry_array_map with the same title/description
      # mark down the ids of the two
      add = true
      valid_entry_array_map.each do |valid_entry|
        if(bare(valid_entry[:description]) == bare(entry[:description])) &&
          (valid_entry[:title].strip == entry[:title].strip)
          duplicate_ids.push([valid_entry[:id], entry[:id]])
          add = false
        end
      end
      if add then valid_entry_array_map.push(entry) end
    end

    puts "Finished, duplicate ids:"
    duplicate_ids.each do |dup|
      puts "Dups: " + dup[0].to_s + ", " + dup[1].to_s
      Entry.destroy(dup[0])
    end
  end
end
