module KMeans
  class SpreadsheetHandler
    def initialize(filepath)
      @filepath = filepath
    end
    # Maps and adds incoming user movie data to movies.csv using imdb ids from links.csv
    def append_user_data(user)
      # We're using tail to quickly get the last row of the csv because it's so large
      cmd = "tail -n 1 #{@filepath}"
      last_line_data = %x(#{cmd}).split(",") # Last line will be of the format "userId,movieId,rating,timestamp\r\n"
      user_id_movielens_format = last_line_data[0].to_i + 1 # The user will be the last

      CSV.open(@filepath, 'a+') do |csv| #a+ is for appending
        user.backlog.entries.each do |entry|
          user_rating = user.get_rating(entry)
          csv << [ user_id_movielens_format,
            user_rating,
            movielens_record_map(entry),
            user_rating.created_at ]
        end
      end

    end

    def movielens_record_map(entry)
      imdb_id = entry.imdb_id
      movielens_id = nil;
      puts imdb_id

      CSV.foreach("#{Rails.root}/lib/k_means/links.csv") do |row|
        puts row['imdbId'].to_s
        if row['imdbId'].to_s == imdb_id
          movielens_id = row['movieId']
          break
        end
      end

      return movielens_id
    end

  end
end
