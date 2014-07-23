class Entry < ActiveRecord::Base
  has_many :associations, dependent: :destroy
  has_many :backlogs, through: :associations

  searchkick

  #should probably change the medium to large some time soon
  has_attached_file :thumbnail, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ":style/missing.png"
  validates_attachment_content_type :thumbnail, :content_type => /\Aimage\/.*\Z/

  validate do |entry|
    UniquenessValidator.new(entry).validate
  end

  class UniquenessValidator
    def initialize(entry)
      @entry = entry
    end

    def validate
      if Entry.where(title: @entry.title, description: @entry.description).exists?
        @entry.errors[:base] << "Duplicate title/description"
      end
    end
  end

  def remove_entry!(backlog_id, entry_id)
    self.associations.find_by(backlog_id: backlog_id, entry_id: entry_id).destroy
  end

  def add_entry!(backlog_id, entry_id)
    logger = Logger.new('log/development.log')
    logger.debug("Backlog: " + backlog_id.to_s + " Entry: " + entry_id.to_s)
    self.associations.create!(backlog_id: backlog_id, entry_id: entry_id)
  end

  #http://api.rottentomatoes.com/api/public/v1.0/movies/770672122.json?apikey=3gh3a35gm2x9x3as2qp69rr4
  def get_feed(endpoint)
    resp = Net::HTTP.get_response(URI.parse(endpoint))
    data = resp.body
    feed = JSON.parse(data)
    return feed
  end
end
