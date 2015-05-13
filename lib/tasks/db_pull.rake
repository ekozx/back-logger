namespace :db do
  desc 'Pull production db to development'
  task :pull => [:dump, :restore]

  task :dump do
    dumpfile = "#{Rails.root}/tmp/latest.dump"
    puts 'PG_DUMP on production database...'
    production = Rails.application.config.database_configuration['production']
    system "heroku pg:backups capture"
    system "curl -o latest.dump `heroku pg:backups public-url -a sushi`"
    puts 'Done!'
  end

  task :restore do
    # dev = Rails.application.config.database_configuration['development']
    # dumpfile = "#{Rails.root}/tmp/latest.dump"
    puts 'PG_RESTORE on development database...'
    system "pg_restore --verbose --clean --no-acl --no-owner -h localhost -d  Log_Flix_development latest.dump"
    puts 'Done!'
  end

  task :pull_attempt do
    puts "Starting pull..."
    system "heroku pg:backups capture"
    system "curl -o latest.dump `heroku pg:backups public-url -a zapcord`"
    system "pg_restore --verbose --clean --no-acl --no-owner -h localhost -d  Log_Flix_development latest.dump"
    puts "Done"
  end
end
