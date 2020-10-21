FROM ubuntu:18.04 as builder

WORKDIR /root/

MAINTAINER paul.mason@splice.co

SHELL [ "/bin/bash", "-l", "-c" ]

# Install vim
RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "vim"]

# Add Package Repositories'
RUN apt-get update && \
    apt-get install -y software-properties-common curl libgmp-dev libssl-dev && \
    apt-add-repository -y ppa:rael-gc/rvm && \
    curl -sL https://deb.nodesource.com/setup_11.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils apt-transport-https tzdata imagemagick libpq-dev postgresql-client-10 nodejs yarn rvm libmagickwand-dev git && \
    apt-get clean && \
    apt-get autoclean

# We need wget to set up the PPA and xvfb to have a virtual screen and unzip to install the Chromedriver
RUN apt-get install -y wget xvfb unzip

# Set up the Chrome PPA
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

# Update the package list and install chrome
RUN apt-get update -y
RUN apt-get install -y google-chrome-stable

RUN apt-get install -y libgconf-2-4

# Set up Chromedriver Environment variables
ENV CHROMEDRIVER_VERSION 83.0.4103.39
ENV CHROMEDRIVER_DIR /chromedriver
RUN mkdir $CHROMEDRIVER_DIR

# Download and install Chromedriver
RUN wget -q --continue -P $CHROMEDRIVER_DIR "http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip"
RUN unzip $CHROMEDRIVER_DIR/chromedriver* -d $CHROMEDRIVER_DIR

# Put Chromedriver into the PATH
ENV PATH $CHROMEDRIVER_DIR:$PATH

# Install Ruby
RUN rvm install 2.5.5 && apt-get autoremove -y

###############################################################################
# Installing GraphVis Library for rails-erd gem
###############################################################################
# Update aptitude with new repo
# Install other software
RUN apt-get -y update && apt-get install -y \
	graphviz \
	default-jdk \
	maven \
	git

# Clone the graphviz-server github repo
RUN git clone https://github.com/omerio/graphviz-server.git /opt/graphviz-server

# Set the current work directory
WORKDIR /opt/graphviz-server

# Run graphviz-server
ENTRYPOINT ["java", "-jar", "/opt/graphviz-server/dist/DotGraphics.jar"]


# Container Configuration
WORKDIR /app
EXPOSE 3000

# Install Gems
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN gem install bundler --version=1.17.3 --no-rdoc --no-ri
ADD Gemfile jobspikr-ruby.gemspec /tmp/
RUN cd /tmp; bundle install --jobs 5
RUN cd /app

COPY . ./
