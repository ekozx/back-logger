class Backlog < ActiveRecord::Base
  belongs_to :user
  has_many :associations, dependent: :destroy
  has_many :entries, through: :associations
  # belongs_to :entry
end
