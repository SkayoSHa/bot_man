web: bundle exec rails server -p $PORT & sidekiq & wait -n
release: bin/rake db:migrate
bot: bin/rake discord:bot
