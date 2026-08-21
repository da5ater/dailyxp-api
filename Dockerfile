FROM ruby:3.4-alpine
RUN apk add --no-cache build-base postgresql-dev tzdata
WORKDIR /app
COPY Gemfile Gemfile.lock* ./
RUN bundle install --without production
COPY . .
EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
