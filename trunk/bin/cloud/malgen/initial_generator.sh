#!/bin/bash

source ../env.sh

# These values are from the Python File malgen.py
# The default value for the data file generated by the Python code is
# events-malstone.dat.  If this is not the value you want, you can override it
# here and pass it using -o ${OUTFILE}
OUTFILE=events-malstone.dat
METAFILE=METADATA.txt

# It is probably best that this matches the list of nodes in nodes.txt.
# The confusion can arise from having IPs in one list and names in the other.
# We use hostname -i here to get the IP address.  If you have a naming
# convention for the machines, you may want to change this
HOST=`hostname -i`

INITIAL_FLAG=0

# The seeding step needs to know how many records in total will be generated.
NUM_NODES=`wc -l ../nodes.txt | awk '{print $1}'`
TOTAL_NUM_BLOCKS=$((${NUM_NODES} * ${NUM_BLOCKS}));

# If you want the override the defult statistical values, you do it here.  For
# example, you could insert -m 35 -p .6 \ bewtween lines
#    ${PYTHON} ${MY_HOME}/${SCRIPTS_DIR}/${MALGEN_HOME}/malgen.py \
# and 
#    -O ${IMPORT_FILE_DIR}/ -o ${OUTFILE} \
# To toggle between strictly following the distribution and generatating exactly
# the specified number of records, use -t, --truncate.  If the flag is not
# present, the distribution is followed.

${PYTHON} ${MY_HOME}/${SCRIPTS_DIR}/${MALGEN_HOME}/malgen.py \
    -O ${IMPORT_FILE_DIR}/ -o ${OUTFILE} \
    ${INITIAL_FLAG} ${INITIAL_BLOCK_SIZE} ${BLOCK_SIZE} ${TOTAL_NUM_BLOCKS}

cd ${IMPORT_FILE_DIR}

mv ${OUTFILE}  ${IMPORT_FILE_DIR}/${DATA_FILE_BASE}-${HOST}-seed.dat
mv ${METAFILE} ${IMPORT_FILE_DIR}/METADATA-malstone-${HOST}-seed.txt

exit 0;