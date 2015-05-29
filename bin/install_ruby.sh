export RBENV_ROOT=/l/local/rbenv
export PATH="$RBENV_ROOT/bin:$RBENV_ROOT/shims:${PATH}"
export JAVA_HOME="/usr/lib/jvm/java-7-openjdk-amd64"

CURRENT_JRUBY="jruby-1.7.20"
CURRENT_CRUBY="2.2.2"
#DEPLOYMENT_GROUP="htdev"

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
        pushd `dirname $0`/../lib/bundler
        rm Gemfile.lock
        bundle install
        rm Gemfile.lock
	unset RBENV_VERSION
    fi
}

function check_package {
    dpkg -s $1 >/dev/null 2>&1

    if [ $? -ne 0 ];
    then
        echo "FAILURE $1 missing, install with 'aptutude install $1'"
        exit 1
    else
        echo "OK $1 present"
    fi
}

check_package openjdk-7-jdk
check_package libssl-dev
check_package libreadline-dev

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

# install ruby versions
install_ruby $CURRENT_JRUBY
install_ruby $CURRENT_CRUBY

rbenv global $CURRENT_CRUBY

# add uninstalls here
#
#

rbenv alias --auto
