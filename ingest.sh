#!/bin/bash

logfile=$1

module use $HOME/lmodfiles/Core
module load xalt/2.10.18-syslog
module list

if [ -z "${logfile}" ] || [ ! -f ${logfile} ]; then
  echo Usage: $0 logfile
  exit -1
fi

env |grep XALT

export XALT_EXECUTABLE_TRACKING="yes"
export XALT_DB_CONF=$XALT_ETC_DIR/xalt_db.conf
#source $HOME/software_usage/venv/bin/activate
python --version
set -x
rm -f leftover*.log*
python $OSC_XALT_DIR/sbin/xalt_syslog_to_db.py \
	--syshost $LMOD_SYSTEM_NAME \
	--reverseMapD $XALT_ETC_DIR/reverseMapD \
 	--leftover leftover.log \
	--confFn $XALT_DB_CONF \
	--syslog ${logfile}
