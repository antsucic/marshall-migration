FROM ruby:3.1.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN apt-get install -y libxml2-dev libxslt1-dev
RUN apt-get install -y postgresql-client
RUN apt-get install -y imagemagick
RUN apt-get install -y curl
RUN apt-get install -y bash

RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/ubuntu/20.04/prod.list | tee /etc/apt/sources.list.d/msprod.list
RUN apt-get update
RUN ACCEPT_EULA=Y apt-get install -y mssql-tools
RUN ACCEPT_EULA=Y apt-get install -y unixodbc-dev
RUN echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc

# Update bunlder
RUN gem update bundler
RUN gem update --system

# Set an environment variable where the app is installed to inside of Docker image:
ENV ROOT_DIR /var/www/app
RUN mkdir -p $ROOT_DIR

# Set working directory, where the commands will be ran:
WORKDIR $ROOT_DIR

# Adding gems
COPY ./Gemfile Gemfile
COPY ./Gemfile.lock Gemfile.lock

# Run bundle install as root user
RUN bundle install --jobs 20 --retry 5

# Adding project files
COPY . $ROOT_DIR

ENTRYPOINT ["tail", "-f", "/dev/null"]
