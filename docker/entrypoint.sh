#!/bin/bash

if [ "${ELASTICSEARCH_LOG_LEVEL}" == 'DEBUG' ]; then
    set -x
fi
ES_HOME=/usr/share/elasticsearch
DATA_DIR=/elasticsearch/storage/${ELASTICSEARCH_CLUSTER_NAME}/data
WORK_DIR=/elasticsearch/${ELASTICSEARCH_CLUSTER_NAME}/work
CONF_DIR=/etc/elasticsearch

JAVA_OPTS=${JAVA_OPTS:-}
ES_JAVA_OPTS="-Des.default.path.home=$ES_HOME -Des.default.path.data=$DATA_DIR -Des.default.path.work=$WORK_DIR -Des.default.path.conf=$CONF_DIR"

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
	export ES_JAVA_OPTS+=" -Xms256M -Xmx$(($num/2))m"
else
	echo "ELASTICSEARCH_MAX_MEMORY env var is invalid: ${ELASTICSEARCH_MAX_MEMORY}"
	exit 1
fi

set -eu
cmd="$1"; shift

exec $cmd "$@" $ES_JAVA_OPTS $JAVA_OPTS