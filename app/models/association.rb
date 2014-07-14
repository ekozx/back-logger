class Association < ActiveRecord::Base
  belongs_to :backlog, class_name: "Backlog"
  belongs_to :entry, class_name: "Entry"

  validates :backlog_id, presence: true
  validates :entry_id, presence: true
end
