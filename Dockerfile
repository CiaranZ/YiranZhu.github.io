FROM ruby:3.3.4-slim-bookworm

ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3

WORKDIR /srv/jekyll

RUN apt-get update \
    && apt-get install --yes --no-install-recommends build-essential git \
    && rm -rf /var/lib/apt/lists/*

COPY Gemfile Gemfile.lock ./

RUN gem install bundler --version 2.5.11 --no-document \
    && bundle _2.5.11_ install

EXPOSE 4000 35729

CMD ["bundle", "_2.5.11_", "exec", "jekyll", "serve", "--source", "/workspace", "--destination", "/srv/jekyll/_site", "--host", "0.0.0.0", "--port", "4000", "--livereload", "--livereload-port", "35729"]
