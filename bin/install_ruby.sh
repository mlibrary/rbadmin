export RBENV_ROOT=/l/local/rbenv
export PATH="$RBENV_ROOT/bin:$RBENV_ROOT/shims:${PATH}"

if [ -z "$JAVA_HOME" ]; then
    export JAVA_HOME=`find /usr/lib/jvm -maxdepth 1 -mindepth 1 -type d | sort -r | head -1`
fi

if [ ! -d "$JAVA_HOME" ]; then
    "Can't find JAVA_HOME"
    exit 1
fi

function clone {
    if [ -d $1 ];
    then
        echo "$1 already present"
    else
        git clone $2
    fi
}

function _mkdir {
    if [ -e $1 ];
    then
        echo "$1 already present"
    else
        mkdir $1
        echo "made dir $1"
    fi
}

function install_ruby {
    if [ -e /$RBENV_ROOT/versions/$1 ];
    then
        echo "$1 already present"
    else
        rbenv install $1
        export RBENV_VERSION=$1
        gem install bundler
        gem install pry
        # ONLY DEV
        # pushd `dirname $0`/../lib/bundler
        # rm Gemfile.lock
        # bundle install
        # rm Gemfile.lock
        unset RBENV_VERSION
    fi
}

function check_package {
    arr=($(echo $1 | tr " " "\n"))

    for p in ${arr[@]}
    do
        dpkg -s $p >/dev/null 2>&1

        if [ $? -eq 0 ];
        then
            echo "OK $p found"
            return
        fi
    done

    echo "FAILURE, package not found: $1"
    exit 1
}

check_package "openjdk-8-jdk openjdk-7-jdk"
check_package libssl-dev
check_package libreadline-dev
check_package "g++"

# install rbenv
pushd /l/local
clone rbenv https://github.com/sstephenson/rbenv.git

# install plugins
cd $RBENV_ROOT
_mkdir plugins
pushd plugins
clone ruby-build https://github.com/sstephenson/ruby-build.git
clone rbenv-update https://github.com/rkh/rbenv-update.git
clone rbenv-aliases https://github.com/tpope/rbenv-aliases.git
popd
popd

# up to date?
rbenv update

source `dirname $0`/../lib/lib.sh

# install ruby versions
install_ruby $CURRENT_JRUBY_UPSTREAM
install_ruby $CURRENT_CRUBY_UPSTREAM

rbenv global $CURRENT_CRUBY_UPSTREAM

# remove outdated ruby versions
for v in "${OUTDATED_CRUBIES[@]}" "${OUTDATED_JRUBIES[@]}"; do
    rbenv uninstall $v
done

rbenv alias --auto
