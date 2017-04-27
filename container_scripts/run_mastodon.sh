#!/bin/sh
source /root/.bashrc

cd /mastodon

rails db:migrate
rails server -b 0.0.0.0 -e development
