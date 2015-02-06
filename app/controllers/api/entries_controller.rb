module Api
  class EntriesController < Api::BaseController
    private
      def entry_params
        params.require(:entry).permit(:title)
      end

      def query_params
        params.permit(:title, :description, :thumbnail_file_name)
      end
  end
end
