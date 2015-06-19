module SpreadsheetHandler
  class Handler
    require 'roo'
    # Loads in a spreadsheet using roo
    def initialize(filepath)
      @spreadsheet = Roo::Spreadsheet.open(filepath)
    end
    # Maps and adds incoming user movie data to movies.csv using imdb ids from links.csv
    def append_incoming_data(incoming_data)
    end
    # Returns the relevant csv
    def get_data
      return @spreadsheet
    end
  end
end
