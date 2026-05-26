#!/usr/bin/env bash

set -e

# Remove the local build
if [ -d www.furrymusic.org ]; then rm -rfv www.furrymusic.org; fi

# Copy static data into the site layout
rsync -av --exclude='.git/' --exclude='.DS_Store' static/ www.furrymusic.org;

# Copy the replacement static site source into the site layout
rsync -av --exclude='.git/' --exclude='.DS_Store' site-next/ www.furrymusic.org

# Stamp the generated pages with the current build timestamp
BUILD_TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S %Z')"
find www.furrymusic.org -name '*.html' -exec perl -0pi -e "s/__LAST_UPDATED__/${BUILD_TIMESTAMP}/g" {} +

# Publish the combined site layout on to the server
rsync -av --exclude='.git/' --exclude='.DS_Store' --delete www.furrymusic.org/ ${MY_WEBUSER}@${MY_WEBHOST}:/var/www/furrymusic.org/www
