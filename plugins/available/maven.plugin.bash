cite about-plugin
about-plugin 'maven helper functions'

usemvn ()
{
	about 'Switches between available Maven versions for the current shell. Lists the available Maven versions if called without a parameter. The root directory for Maven installations can be defined using the variable MAVEN_INSTALL_ROOT. If this is not defined, /usr/local is assumed. The Maven directories under this directory are expected to be named apache-maven-*'
	group 'maven'
	param '1: Maven version to switch to'
	example 'usemvn 3.0.4'
	
	if [ -z "$MAVEN_INSTALL_ROOT" ]
	then
		local MAVEN_INSTALL_ROOT="/usr/local"
	fi
	
    if [ -z "$1" -o ! -x "$MAVEN_INSTALL_ROOT/apache-maven-$1/bin/mvn" ]
    then
    	echo "Looking for Maven installations in $MAVEN_INSTALL_ROOT/apache-maven-*"
        local prefix="Syntax: usemvn "
        for i in $MAVEN_INSTALL_ROOT/apache-maven-*
        do
            if [ -x "$i/bin/mvn" ]; then
                echo -n "$prefix$(basename $i | sed 's/^apache-maven-//')"
                prefix=" | "
            fi
        done
        echo ""
    else
        if [ -z "$MAVEN_HOME" ]
        then
            export PATH=$MAVEN_INSTALL_ROOT/apache-maven-$1/bin:$PATH
        else
            export PATH=$(echo $PATH|sed -e "s:$MAVEN_HOME/bin:$MAVEN_INSTALL_ROOT/apache-maven-$1/bin:g")
        fi
        export MAVEN_HOME=$MAVEN_INSTALL_ROOT/apache-maven-$1
    fi
}