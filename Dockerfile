FROM ruby

RUN apt-get update -qq && apt-get install -y build-essential

RUN mkdir -p /app 
WORKDIR /app

COPY Gemfile Gemfile.lock ./ 
RUN gem install bundler && bundle install --jobs 20 --retry 5

COPY . ./

EXPOSE 3000

# Nokogiri dependencies
RUN apt-get install -y libxml2-dev libxslt1-dev

# JS runtime dependencies
RUN apt-get install -y nodejs

CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]