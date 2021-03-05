FROM ruby:2.7.2

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update -qq && apt-get install -qq --no-install-recommends \
    nodejs \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome*.deb || apt update && apt-get install -f -y

RUN npm install -g yarn@1.22.10

COPY Gemfile* /usr/src/app/
WORKDIR /usr/src/app
RUN bundle install

COPY . /usr/src/app/

RUN bin/rails assets:precompile

# Redirect Rails log to STDOUT for Cloud Run to capture
ENV RAILS_LOG_TO_STDOUT=true

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
