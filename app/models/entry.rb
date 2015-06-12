class Entry < ActiveRecord::Base
  has_many :associations, dependent: :destroy
  has_many :backlogs, through: :associations
  has_many :zaps

  searchkick

  #should probably change the medium to large some time soon
  has_attached_file :thumbnail, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => ":style/missing.png"
  validates_attachment_content_type :thumbnail, :content_type => /\Aimage\/.*\Z/
  validates :title, uniqueness: {case_sensative: false}
  validates_with UniquenessValidator, attributes: [:title]

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
  def self.get_feed(endpoint)
    resp = Net::HTTP.get_response(URI.parse(endpoint))
    data = resp.body
    feed = JSON.parse(data)
    return feed
  end

  # Create a "coordinate" by querying rotten tomatoes and making an object
  # We must query then loop here, as Rotten Tomatoes does not provide a find imdb_id
  # STORE ROTTEN TOMATOES ID
  def coordinate_attributes(imdb_id, title)
    attributes = {}
    endpoint = "http://api.rottentomatoes.com/api/public/v1.0/movies.json?apikey=" +
      ENV["ROTTEN_TOMATOES_KEY"] + "&q=" + title.gsub(" ", "+") + "&page_limit=20"
    resp = self.get_feed(endpoint)
    found_movie = false
    unless resp.blank?
      count = 0
      while !found_movie && count < resp["movies"].size do
        movie = resp["movies"][count]
        if movie["alternate_ids"]["imdb"] == imdb_id
          found_movie = true
          # attributes["directors"] =
        end
        count += 1
      end
    end
    return attributes
  end

  # Inner classes

  # A coordinate for an entry to be used in suggestions
  class DataPoint
    def initialize(entry)
      attrs = coordinate_attributes(entry.imdb_id, entry.title)
    end

    # Computes the "distance" between entries as an integer, x, such that 0 <= x <= 3
    # Uses the directors (3), genre (1*num), actors(1*num), mpaa rating(2) and studio(3)
    # to determine similarity between points. Weights for each are in parenthesis.
    def distance(point)
      distance = 0
      entry_coordinate = generate_coordinate
      return distance
    end
  end

  class UniquenessValidator < ActiveModel::Validator
    def bare s
      return s.gsub(/[-()'*,.]/, "").strip.downcase
    end
    def validate(entry)
      entries = Entry.where(title: entry.title)
      if entries.count > 0
        descriptions = entries.pluck(:description)
        test_description = bare(entry.description)
        descriptions.each do |description|
          if bare(description) == bare(test_description)
            entry.errors[:base] << "Duplicate title/description parir"
          end
        end
      end
    end
  end

end
