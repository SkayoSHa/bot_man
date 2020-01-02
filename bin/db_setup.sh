#!/bin/bash
set -e

# Bot Man DB setup
docker-compose exec web-bot rake db:drop
docker-compose exec web-bot rake db:create
# Do schema setup things here
docker-compose exec web-bot rake db:migrate
docker-compose exec web-bot rake db:create RAILS_ENV=test
