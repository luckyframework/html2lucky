FROM crystallang/crystal:0.27.0
WORKDIR /data

# For the Lucky server
EXPOSE 5000
# For running crystal play
EXPOSE 8080

RUN apt-get update && \
  apt-get install -y libnss3 libgconf-2-4 chromium-browser curl libreadline-dev golang-go postgresql postgresql-contrib && \
  # Set up node and yarn
  curl --silent --location https://deb.nodesource.com/setup_11.x | bash - && \
  apt-get install -y nodejs && \
  npm install -g yarn && \
  # Install Heroku CLI as process manager
  curl https://cli-assets.heroku.com/install.sh | sh && \
  # Lucky cli
  git clone https://github.com/luckyframework/lucky_cli --branch v0.12.0 --depth 1 /usr/local/lucky_cli && \
  cd /usr/local/lucky_cli && \
  shards install && \
  crystal build src/lucky.cr -o /usr/local/bin/lucky && \
  # Clean things up
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Install shards
COPY shard.* ./
RUN shards install

# Yarn
COPY package.json yarn.lock ./
RUN yarn install

COPY . /data
