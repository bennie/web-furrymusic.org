#!/usr/bin/env bash

set -e

# Remove the local build
if [ -d www.furrymusic.org ]; then rm -rfv www.furrymusic.org; fi

# Copy static data into the site layout
rsync -av --exclude='.git/' --exclude='.DS_Store' static/ www.furrymusic.org;

# Update Jekyll and include it's output
cd feeling-responsive; bundle exec jekyll build; cd ..;

# Copy the rendered Jekyll output into the site layout
rsync -av --exclude='.git/' --exclude='.DS_Store' feeling-responsive/_site/ www.furrymusic.org

# Publish the combined site layout on to the server
rsync -av --exclude='.git/' --exclude='.DS_Store' --delete www.furrymusic.org/ ${MY_WEBUSER}@${MY_WEBHOST}:/var/www/furrymusic.org/www
