#!/bin/bash
source /usr/share/rvm/scripts/rvm

# "docker-compose down" does not remove pid files
#rm -f tmp/pids/server.pid

# Download dependencies
bundle check || bundle install --jobs 20

# Start Server
./bin/console