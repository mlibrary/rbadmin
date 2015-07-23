CURRENT_CRUBY_UPSTREAM=`rbenv install --list | grep ' [0-9]' | egrep -v "(dev|pre|rc)" | tail -1 | awk '{ print $1 }'`
CURRENT_JRUBY_UPSTREAM=`rbenv install --list | grep jruby    | egrep -v "(dev|pre|rc)" | tail -1 | awk '{ print $1 }'`

CURRENT_CRUBY_INSTALLED=`rbenv versions --bare | sort -V | grep '^[0-9]' | egrep -v "(dev|pre|rc)" | tail -1`
CURRENT_JRUBY_INSTALLED=`rbenv versions --bare | sort -V | grep '^jruby' | egrep -v "(dev|pre|rc)" | tail -1`
