# rbadmin
Tools for managing system wide rbenv installation. Supports Debian and OS X. Requires gnu core-utils on OS X.

## install_ruby
Installs rbenv and (by default) the latest MRI and JRruby.

## update_ck
Updates rbenv and checks if ruby installs are up to date. Designed to be run out of cron, it's silent unless there is a new version.

## rbenv_profile
Source this to use the rbenv we install.
