from ruby:2.4.0

RUN apt-get update -qq
RUN apt-get install -y build-essential nodejs

RUN mkdir app
WORKDIR app

ADD Gemfile /app/Gemfile
ADD Gemfile.lock /app/Gemfile.lock
RUN bundle install
ADD . /app

CMD ["./script/run_tests.sh"]
