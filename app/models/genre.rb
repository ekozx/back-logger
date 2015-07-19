class Genre < ActiveRecord::Base
  has_many :entries
end
