#!/usr/bin/dumb-init /bin/sh

# ENV. for dev/prd future usage
GIN_MODE="debug"
if [ $TARGET == "prd" ] || [ $TARGET == "production" ]; then
    GIN_MODE="release"
fi
export GIN_MODE

echo "Start $APP"
echo "TARGET=$TARGET"
echo "GIN_MODE=$GIN_MODE"

/usr/bin/app/app
