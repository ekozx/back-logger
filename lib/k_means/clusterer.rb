module KMeans
  include SpreadsheetHandler
  class Clusterer
    def initialize(data_type, incoming_data)
      if data_type != 'default'
        # load_some_custom_data
      else # default to clustering movies based on MovieLens data
        # Initialize and add user to existing csv
        @spreadsheet_handler = SpreadsheetHandler::Handler.new('./ratings.csv') #gotta move this file
        # Add new data to file, return the users id within ratings.csv
        @spreadsheet_user_id = @spreadsheet_handler.append_incoming_data(incoming_data)
        # Return newly populated data as a hash
        @data = @spreadsheet_handler.get_data()
      end
    end

    def k_means

    end
  end
end
