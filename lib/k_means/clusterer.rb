include SpreadsheetHelper

module KMeans
  class Clusterer

    def initialize(data)
      @spreadsheet_handler = SpreadsheetHelper::Helper.new(data) #gotta move this file
      if data != 'default'
        # load_some_custom_data
      else

      end
    end

    def k_means
    end
  end
end
