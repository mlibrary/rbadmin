UNAME=`uname`
DISTRO=`lsb_release -si 2>/dev/null`

if [ "$UNAME" == "Darwin" ]; then
    export OS="X"
elif [ "$DISTRO" == "Debian" ]; then
    export OS="Debian"
else
    echo "Sorry, your OS is not yet supported. Feel free to submit a pull request."
    exit 1
fi
