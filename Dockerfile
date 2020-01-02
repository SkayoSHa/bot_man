# Debian stretch is version 9 of the OS and is the current stable
# version as of this writing. If this is ever changed to a different
# OS version, the repo addition commands below might need to be updated.
FROM ruby:latest

EXPOSE 3000
WORKDIR /app

# Adds the following repos and packages (in order)
# * nodejs for JavaScript building (needed by yarn)
# * yarn to manage JavaScript dependencies and installation for webpack and asset pipeline
# * postgresql for the psql binary and client libraries needed to build the pg gem and execute certain rake tasks
# * google-chrome-stable to execute and render pages for browser tests
#
# Also installed:
# * python + pip for aws s3 cli functionality
# * apt-transport-https for yarn package repo access (should be already installed, but is in this list just in case)
# * unzip to complete the chromedriver installation
# * vim for file editing (specifically for "hard core" debuging of gems which are installed in the shared volume)
RUN \
  curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  echo "deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list && \
  wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
  wget --quiet -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - && \
  echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" | tee /etc/apt/sources.list.d/google.list && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
  apt-transport-https \
  python \
  python-dev \
  python-pip \
  python-setuptools \
  nodejs \
  yarn \
  postgresql-client-12 \
  vim \
  && rm -rf /var/lib/apt/lists/*

ENV BUNDLE_PATH=/bundle \
  BUNDLE_BIN=/bundle/bin \
  GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"

# awscli is used to pull base databases
RUN pip install wheel
RUN pip install awscli psycopg2-binary --upgrade

COPY docker-entry.sh .

# Add the GPG conf file to allow loopback pinentry
RUN mkdir ~/.gnupg
RUN echo "allow-loopback-pinentry" | tee ~/.gnupg/gpg-agent.conf

ENTRYPOINT ["/app/docker-entry.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]
