#!/bin/bash
#
# Author: EGGMAN.TV
#
# Usage:
# 
# ./deploy.sh production|staging
#

if [[ $# == 0 ]]; then
  echo "Usage ./deploy.sh production|staging"
  exit 1
fi

ENV=$1

# Configs
USER=deploy
BUNDLE_GEMS_PATH=/path/to/bundle/gems
if [[ $ENV == 'production' ]]; then
  HOST=www.hello.com
  BRANCH=master
  WWW_ROOT=/var/nginx/html/hello
elif [[ $ENV == 'staging' ]]; then
  HOST=dev.hello.com
  BRANCH=dev
  WWW_ROOT=/var/nginx/html/hello
else
  echo "Usage ./deploy.sh production|staging"
  exit 1
fi

echo "start deploying..."
echo "*********************"
echo "host: $HOST"
echo "env: $ENV"
echo "www root: $WWW_ROOT"
echo "branch: $BRANCH"
echo "bundle gems path: $BUNDLE_GEMS_PATH"
echo "*********************"

# -t: close ssh connection when finished
ssh -t $USER@$HOST "\
echo logged in $HOST successfully;
echo $ENV:
echo -------------;
echo -n ruby: ;
echo `which ruby`;
echo -n rake: ;
echo `which rake`;
echo -n bundle: ;
echo `which bundle`;

cd $WWW_ROOT;

echo -n directory:  
pwd;
git checkout $BRANCH;
echo -n branch: ;
git branch | fgrep '*' | cut -d \" \" -f 2;
echo -n current git log SHA1: ;
git log -n 1 | grep 'commit ' | cut -d \" \" -f 2;

echo update code;
echo start git pull...;
git checkout .;
git pull;

echo bundle install...;
bundle install --path $BUNDLE_GEMS_PATH --without development test --deployment;
echo compiling assets...;
bundle exec rails assets:precompile RAILS_ENV=$ENV;
echo start migrate...;
bundle exec rails db:migrate RAILS_ENV=$ENV;

echo reload or start unicorn...;
if [ -f tmp/pids/unicorn.pid ]; then
  echo reload unicorn...;
  kill -s USR2 `cat tmp/pids/unicorn.pid`;
else
  echo start unicorn...;
  bundlle exec unicorn_rails -c config/unicorn.rb -E $ENV -D
fi

sleep 2;
echo DONE!
"
