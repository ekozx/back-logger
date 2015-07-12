module KMeans
  # include SpreadsheetHandler
  class Clusterer
    def initialize(data_type, user)
      if data_type != 'default'
        # load_some_custom_data
        puts "custom data implementation here"
      else # default to clustering movies based on MovieLens data
        @handler = SpreadsheetHandler.new("#{Rails.root}/lib/k_means/ratings.csv")
        @handler.append_user_data(user)
      end
      puts "finished initializing cluster"
    end

    def k_means

    end
  end
end
