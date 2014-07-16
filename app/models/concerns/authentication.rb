module Authentication
  extend ActiveSupport::Concern

  included do
  end

  module ClassMethods
    # log = Logger.new("log/development.log")
    def find_for_oauth(auth)
      record = User.where(provider: auth.provider, uid: auth.uid.to_s).first
      # log.debug("RECORD")
      # log.debug(record)
      unless record.blank? record
      end
    end
  end
end
