class GenreMapping < ActiveRecord::Base
  belongs_to :entry, class_name: "Entry"
  belongs_to :genre, class_name: "Genre"
  validates :genre_id, presence: true
  validates :entry_id, presence: true
end
