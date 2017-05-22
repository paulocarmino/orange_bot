FROM ruby:2.4.1-slim

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
    build-essential nodejs libpq-dev

ENV INSTALL_PATH /bot

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

COPY Gemfile Gemfile.lock ./

ENV BUNDLE_GEMFILE=$INSTALL_PATH/Gemfile \
  BUNDLE_JOBS=2 \
  BUNDLE_PATH=/box

COPY . .
