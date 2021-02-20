

RAILS_ENV=production bundle exec rake db:create

# Make sure we are using the most up to date
# database schema
RAILS_ENV=production bundle exec rake db:migrate

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bundle exec rails s -p 3000 -b '0.0.0.0'