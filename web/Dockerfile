FROM ruby:2.2.0
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN mkdir /hellorails
WORKDIR /hellorails
RUN gem install rails -v '4.2.0' --no-ri --no-rdoc
RUN rails new . --force --database=postgresql --skip-bundle
ADD Gemfile /hellorails/Gemfile
ADD database.yml /hellorails/config/database.yml
RUN bundle install
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
