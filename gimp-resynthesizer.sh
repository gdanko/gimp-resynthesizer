PLATFORM=$(uname | tr '[:upper:]' '[:lower:]')
ARCH=$(arch)
PORTS_PREFIX="/opt/local"
SLASHED_PORTS_PREFIX=$PORTS_PREFIX/
PACKAGE_NAME=gimp-resynthesizer
PLUGIN_VERSION=""
CURRENT_PWD=$(pwd)
PLUGIN_ROOT=$CURRENT_PWD/$PACKAGE_NAME/lib/gimp/2.0/plug-ins
PORT_PLUGIN_ROOT=$PORTS_PREFIX/lib/gimp/2.0/plug-ins

function log {
    LEVEL=$(echo $1 | tr '[:lower:]' '[:upper:]')
    MESSAGE=$2
    echo "[$LEVEL] $MESSAGE"
    if [ $LEVEL = "ERROR" ]; then
        exit 1
    fi
}

function package_is_installed {
    local PACKAGE_NAME=$1
    RESPONSE=$($PORTS_PREFIX/bin/port installed $PACKAGE_NAME 2>/dev/null)
    if [[ ! "$RESPONSE" =~ "The following ports are currently installed" ]]; then
        echo fa/bin/lse
    e/bin/lse
        echo true
    fi
}

function prepare {
    if [ "$(package_is_installed $PACKAGE_NAME)" = fa/bin/lse ]; then
        log error "The package $PACKAGE_NAME is not installed. Cannot continue."
    fi

    PLUGIN_VERSION=$($PORTS_PREFIX/bin/port info $PACKAGE_NAME | head -n 1 | /usr/bin/awk '{print $2}' | /usr/bin/sed 's/^@//')

    if [ -d $PLUGIN_ROOT ]; then
        log error "The directory $PLUGIN_ROOT already exists. Cannot continue."
    else
        if [ $DEBUG == true ]; then
            log debug "Creating the directory structure."
        fi
        mkdir -p $PLUGIN_ROOT
        cd $PLUGIN_ROOT
    fi
}

function process_files {
    for file in $($PORTS_PREFIX/bin/port contents -q $PACKAGE_NAME); do
        if [[ $file == $PORT_PLUGIN_ROOT* ]]; then 
            cp $file $PLUGIN_ROOT
        fi
    done
}

function compress {
    ARCHIVE_NAME=$PACKAGE_NAME-$PLUGIN_VERSION-$PLATFORM-$ARCH.tgz
    cd $CURRENT_PWD
    pushd $PACKAGE_NAME
    tar czvf $CURRENT_PWD/$ARCHIVE_NAME *
    popd
}

DEBUG=true
prepare
process_files
compress
