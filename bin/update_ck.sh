#!/bin/bash

source `dirname $0`/rbenv_profile

rbenv rehash > /dev/null
rbenv update > /dev/null

CURRENT_CRUBY_UPSTREAM=`rbenv install --list | grep ' [0-9]' | egrep -v "(dev|pre|rc)" | tail -1 | awk '{ print $1 }'`
CURRENT_JRUBY_UPSTREAM=`rbenv install --list | grep jruby    | egrep -v "(dev|pre|rc)" | tail -1 | awk '{ print $1 }'`

CURRENT_CRUBY_INSTALLED=`rbenv versions --bare | sort -V | grep '^[0-9]' | egrep -v "(dev|pre|rc)" | tail -1`
CURRENT_JRUBY_INSTALLED=`rbenv versions --bare | sort -V | grep '^jruby' | egrep -v "(dev|pre|rc)" | tail -1`

function match_or_complain {
    if [ "$1" != "$2" ]; then
        echo "Ruby version $2 is out of date $1 available"
    fi
}

match_or_complain $CURRENT_CRUBY_UPSTREAM $CURRENT_CRUBY_INSTALLED
match_or_complain $CURRENT_JRUBY_UPSTREAM $CURRENT_JRUBY_INSTALLED

