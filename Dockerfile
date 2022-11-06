FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get install -y libxml2-dev libxslt1-dev
RUN apt-get install -y postgresql-client
RUN apt-get install imagemagick

# Update bunlder
RUN gem update bundler
RUN gem update --system

# Set an environment variable where the app is installed to inside of Docker image:
ENV ROOT_DIR /var/www/app
RUN mkdir -p $ROOT_DIR

# Set working directory, where the commands will be ran:
WORKDIR $ROOT_DIR

# Setting development user
ARG USER_ID
ARG GROUP_ID

RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
    groupadd -g ${GROUP_ID} app && \
    useradd -rm -d /home/app -s /bin/bash -g root -G sudo -u ${USER_ID} app \
;fi

RUN if [ ${USER_ID:-0} -ne 0 ] && [ ${GROUP_ID:-0} -ne 0 ]; then \
    chown --recursive ${USER_ID}:${GROUP_ID} ./ /usr/local/ \
;fi

USER app

# Adding gems
COPY ./Gemfile Gemfile
COPY ./Gemfile.lock Gemfile.lock

# Run bundle install as root user
RUN bundle install --jobs 20 --retry 5

# Adding project files
COPY . $ROOT_DIR

ENTRYPOINT ["tail", "-f", "/dev/null"]
