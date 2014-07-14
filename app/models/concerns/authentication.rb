module Authentication
  extend ActiveSupport::Concern

  included do 
  end

  module ClassMethods
    def find_for_oauth(auth)
      record = User.where(provider: auth.provider, uid: auth.uid.to_s).first
      log = Logger.new("log/development.log")
      log.debug("RECORD")
      log.debug(record)
      if record == nil
        log.debug("CREATING...")
        log.debug(auth)
        log.debug(auth.provider)
        log.debug(auth.email)
        create(provider: auth.provider, uid: auth.uid, email: auth.info.email, password: Devise.friendly_token[0,20])
      else
        record
      end
    end
  end
end