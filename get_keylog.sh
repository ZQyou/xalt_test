#!/bin/bash

grep /opt/conda/bin/gfClient owens_20210608.log  | grep -oh -P 'key:run_fini_.*?idx' > gfclient_key.log 
