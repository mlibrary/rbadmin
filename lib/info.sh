SORT="sort"
HEAD="head"

if [ "$OS" == "X" ]; then
    SORT="gsort"
    HEAD="ghead"
fi

CURRENT_CRUBY_UPSTREAM=`rbenv install --list | grep ' [0-9]' | egrep -v "(dev|pre|rc)" | tail -1 | awk '{ print $1 }'`
CURRENT_JRUBY_UPSTREAM=`rbenv install --list | grep jruby    | egrep -v "(dev|pre|rc)" | tail -1 | awk '{ print $1 }'`

CURRENT_CRUBY_INSTALLED=`rbenv versions --bare | ${SORT} -V | grep '^[0-9]' | egrep -v "(dev|pre|rc)" | tail -1`
CURRENT_JRUBY_INSTALLED=`rbenv versions --bare | ${SORT} -V | grep '^jruby' | egrep -v "(dev|pre|rc)" | tail -1`

OUTDATED_CRUBIES=(`comm -12 <(rbenv versions --bare | ${SORT} | grep '^[0-9]' | egrep -v "(dev|pre|rc)") <(rbenv install --list | awk '{ print $1 }' | ${SORT}) | ${HEAD} -n -2`)
OUTDATED_JRUBIES=(`comm -12 <(rbenv versions --bare | ${SORT} | grep '^jruby' | egrep -v "(dev|pre|rc)") <(rbenv install --list | awk '{ print $1 }' | ${SORT}) | ${HEAD} -n -2`)
