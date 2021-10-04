#!/usr/bin/dumb-init /bin/sh

# ENV. for dev/prd future usage
export SPRING_PROFILES_ACTIVE=$TARGET

echo "Start $APP WAS"
echo "TARGET=$TARGET"
echo "JAVA_OPTS=$JAVA_OPTS"
echo "SPRING_PROFILES_ACTIVE=$SPRING_PROFILES_ACTIVE"

/usr/bin/java $JAVA_OPTS org.springframework.boot.loader.JarLauncher