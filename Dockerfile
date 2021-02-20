FROM ruby:2.7.2

LABEL maintainer=sergioibanezmoreno@gmail.com

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN curl -sL https://deb.nodesource.com/setup_11.x | bash -
RUN apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN npm install -g yarn@1.22.10

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install

COPY . /usr/src/app/

RUN bin/rails assets:precompile

# Redirect Rails log to STDOUT for Cloud Run to capture
ENV RAILS_LOG_TO_STDOUT=true

RUN RAILS_ENV=production RAILS_MASTER_KEY=$RAILS_MASTER_KEY bundle exec rake db:create

# Make sure we are using the most up to date
# database schema
RUN RAILS_ENV=production RAILS_MASTER_KEY=$RAILS_MASTER_KEY bundle exec rake db:migrate

CMD ["bin/rails", "s", "-b", "0.0.0.0"]