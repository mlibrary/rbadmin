#!/bin/bash

source `dirname $0`/rbenv_profile

rbenv rehash > /dev/null
rbenv update > /dev/null

source `dirname $0`/../lib/lib.sh

function match_or_complain {
    if [ "$1" != "$2" ]; then
        echo "Ruby version $2 is out of date $1 available"
    fi
}

match_or_complain $CURRENT_CRUBY_UPSTREAM $CURRENT_CRUBY_INSTALLED
match_or_complain $CURRENT_JRUBY_UPSTREAM $CURRENT_JRUBY_INSTALLED
