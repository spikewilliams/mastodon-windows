#!/bin/sh
source /root/.bashrc


cd /railsapp
git clone https://github.com/tootsuite/mastodon.git
ln -s /railsapp/mastodon /mastodon

cd mastodon
bundle install

npm install prebuild
yarn install --no-bin-links
npm install browserify browserify-incremental
