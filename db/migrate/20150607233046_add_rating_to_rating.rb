class AddRatingToRating < ActiveRecord::Migration
  def change
    add_column :ratings, :rating, :integer
  end
end
