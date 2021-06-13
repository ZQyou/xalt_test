#!/bin/bash

logfile=$1

module use $HOME/lmodfiles/Core
module load xalt/2.10.10-syslog
#module load xalt/2.10.11-syslog
#module load xalt/2.10.14-syslog
#module load xalt/osc
module list

if [ -z "${logfile}" ] || [ ! -f ${logfile} ]; then
  echo Usage: $0 logfile
  exit -1
fi

env |grep XALT

export XALT_EXECUTABLE_TRACKING="yes"
#export XALT_DB_CONF=/fs/ess/PZS0710/xalt/etc/pitzer/xalt_db.conf
export XALT_DB_CONF=$XALT_ETC_DIR/xalt_db.conf
#source $HOME/software_usage/venv/bin/activate
set -x
python2 $OSC_XALT_DIR/sbin/xalt_syslog_to_db.py \
	--syshost pitzer \
	--reverseMapD $XALT_ETC_DIR/reverseMapD \
	--leftover leftover_pitzer.log \
	--confFn $XALT_DB_CONF \
	--syslog ${logfile}
