#!/bin/bash

if [ "${ELASTICSEARCH_LOG_LEVEL}" == 'DEBUG' ]; then
    set -x
fi
export ES_HOME=/usr/share/elasticsearch
export DATA_DIR=/elasticsearch/persistent/${ELASTICSEARCH_CLUSTER_NAME}/data
export WORK_DIR=/elasticsearch/${ELASTICSEARCH_CLUSTER_NAME}/work
export CONF_DIR=/etc/elasticsearch

JAVA_OPTS=${JAVA_OPTS:-}
ES_JAVA_OPTS=""

mkdir -p /elasticsearch/persistent/$ELASTICSEARCH_CLUSTER_NAME/data
mkdir -p /elasticsearch/$ELASTICSEARCH_CLUSTER_NAME/work

# the amount of RAM allocated should be half of available instance RAM.
regex='^([[:digit:]]+)([GgMm])$'
if [[ "${ELASTICSEARCH_MAX_MEMORY}" =~ $regex ]]; then
	num=${BASH_REMATCH[1]}
	unit=${BASH_REMATCH[2]}
	if [[ $unit =~ [Gg] ]]; then
		((num = num * 1024)) # enables math to work out for odd gigs
	fi
	if [[ $num -lt 512 ]]; then
		echo "ELASTICSEARCH_MAX_MEMORY set to ${ELASTICSEARCH_MAX_MEMORY} but must be at least 512M"
		exit 1
	fi
	echo "Setting ES_HEAP_SIZE to: ${num}m"
	#export ES_HEAP_SIZE=${num}m
	ES_JAVA_OPTS="$ES_JAVA_OPTS -Xmx${num}m"
else
	echo "ELASTICSEARCH_MAX_MEMORY env var is invalid: ${ELASTICSEARCH_MAX_MEMORY}"
	exit 1
fi

set -eu
cmd="$1"; shift
echo $cmd "$@" $JAVA_OPTS $ES_JAVA_OPTS
#exec $cmd "$@" $ES_JAVA_OPTS
exec $cmd "$@"
