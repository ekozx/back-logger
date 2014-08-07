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
      entries = Entry.where(title: @entry.title)
      if entries.count > 0
        if entries.where(description: @entry.description).count > 0
          @entry.errors[:base] << "Duplicate title/description pair"
        end
      end
    end
  end

  def update_photo
    Tmdb::Api.key(ENV["TMDB_KEY"])
    logger = Logger.new('log/development.log')
    logger.debug("FILM")
    logger.debug(self)
    #update the photo on show
    if self.photo.blank? && !self.imdb_id.blank?
      query = Tmdb::Find.imdb_id("tt" + self.imdb_id)
      movie_results = query.movie_results
      unless movie_results.blank?
        movie = movie_results.first
        unless movie.blank?
          self.photo = movie.poster_path
          logger.debug("SAVING:")
          self.save!(validate: false)
        end
        logger.debug(self)
      end
    end
  end

  def remove_entry!(backlog_id, entry_id)
    self.associations.find_by(backlog_id: backlog_id, entry_id: entry_id).destroy
  end

  def add_entry!(backlog_id, entry_id)
    logger = Logger.new('log/development.log')
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
