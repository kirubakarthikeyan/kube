FROM ruby:3.2

RUN mkdir -p /base
WORKDIR /base

RUN apt-get update && apt-get install -y nodejs nano

ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

COPY Gemfile /base/
COPY Gemfile.lock /base/

RUN bundle install

COPY . /base

EXPOSE 3000

CMD ["rails", "s", "-b", "0.0.0.0"]
