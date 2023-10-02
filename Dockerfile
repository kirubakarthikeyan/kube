FROM ruby:3.2

RUN mkdir -p /kube
WORKDIR /kube

RUN apt-get update && apt-get install -y nodejs nano

ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true
ENV RAILS_LOG_TO_STDOUT true

COPY Gemfile /kube/
COPY Gemfile.lock /kube/

COPY . /kube

EXPOSE 3000

CMD ["rails", "s", "-b", "0.0.0.0"]

#https://snyk.io/blog/10-docker-image-security-best-practices/
