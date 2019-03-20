env :GEM_PATH, '/usr/local/bundle' # defines where to find rake command
set :output, '/var/log/cron.log' # log location

# We override rake job type, as we don't want envrinoment specific task
job_type :rake, "cd :path && bundle exec rake :task --silent :output"

# runs every minute
every 1.minute do
  # this will log in cron.log as defined above.
  rake 'log_to_console'
end
