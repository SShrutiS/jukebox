# DEVELOPMENT DOCKERFILE

FROM ruby:2.4.1

RUN apt-get update && apt-get install vim postgresql-client redis-tools cifs-utils -y

RUN gem install rails

RUN cd /usr/local                                                        \
    && wget https://nodejs.org/dist/v8.4.0/node-v8.4.0-linux-x64.tar.xz  \
    && tar -xvf node-v8.4.0-linux-x64.tar.xz                             \
    && mv node-v8.4.0-linux-x64 node                                     \
    && rm node-v8.4.0-linux-x64.tar.xz

ENV PATH "/usr/local/node/bin:$PATH"
ENV PORT "3333"
ENV HOST "0.0.0.0"
ENV RAILS_ENV "development"

RUN npm i -g yarn
COPY . /usr/src/app
WORKDIR /usr/src/app

RUN bundle install

ENV RAILS_SERVE_STATIC_FILES "true"
ENV SECRET_KEY_BASE "c12d56aef1d35df69f4de6e9f001713e22df04db03b15e533ff31f5faaad3d1d621d461859f10ba22aa35c90a7fcd607187660586f7a1a3e67f0316214608f94"
RUN rails assets:clobber && rails assets:precomplie

EXPOSE 3333
CMD ["rails", "server"]