module Api
  module V1
    class EntriesController < ApplicationController
      before_action :entry_params, only: [:show, :update, :destroy]
      def index
        # @entries = Entry.all
        # @entries = @entries.search(params[:q]) if params[:q]
        # Entry.search query, page: params[:page], per_page: 10
        if (params[:page] && params[:q])
          @entries = Entry.search params[:q], page: params[:page], per_page: 10
        else
          if params[:q]
            @entries = Entry.search params[:q], page: 1, per_page: 10
          else
            @entries = Entry.page(1).per(10)
          end
        end
        render json: @entries, status: :ok
      end
      private

        def entry_params
          params.require(:entry).permit(:title)
        end

        def query_params
          params.permit(:title, :description, :thumbnail_file_name)
        end
        # def show
        #   @entry = Entry.find(params[:id])
        #   render json: @entry
        # end
        # def destroy
        #   @entry.destroy
        #   head :no_content
        # end
        # def update
        #   if @entry.update(entry_param)
        #     head :no_content
        #   else
        #     render json: @entry.errors, status: :unprocessable_entity
        #   end
        # end
        # def create
        #   @entry = Entry.new(params[:entry])
        #   if @entry.save
        #     render json: @entry, status: :created
        #   else
        #     render json: @entry.errors, status: :unprocessable_entity
        #   end
        # end
    end
  end
end
