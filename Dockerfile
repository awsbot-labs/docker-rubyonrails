FROM ruby:2.2.0
MAINTAINER David Reay <dcrbsltd@gmail.com>

ENV APP RubyOnRails
ENV DB postgres

# Install deps for postgres, nokogiri 
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev libxml2-dev libxslt1-dev
RUN gem install rails -v '4.2.0' --no-ri --no-rdoc

ENV APP_HOME /src
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

RUN rails new . --force --database=postgresql --skip-bundle
ADD Gemfile $APP_HOME/Gemfile
ADD database.yml $APP_HOME/config/database.yml

RUN bundle install

COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
