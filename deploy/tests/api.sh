#!/usr/bin/env bash

# Is the bill's catch line included?
OUTPUT="$(curl --silent http://localhost:5001/1.1/bill/2019/sb1604.json | jq '.catch_line')"
EXPECTED='"Cruelty to animals; increases penalty."';
if [ "$OUTPUT" != "$EXPECTED" ]
then
    echo "ERROR: Bill's catch line isn't included"
    ERRORED=true
fi

# Is the bill's patron shortname correct?
OUTPUT="$(curl --silent http://localhost:5001/1.1/bill/2019/sb1604.json | jq '.patron_shortname')"
EXPECTED='"wrdesteph"';
if [ "$OUTPUT" != "$EXPECTED" ]
then
    echo "ERROR: Bill's patron shortname isn't correct"
    ERRORED=true
fi

# Is the legislator's formatted name correct?
OUTPUT="$(curl --silent http://localhost:5001/1.1/legislator/rbbell.json | jq '.name_formatted')"
EXPECTED='"Del. Rob Bell (R-Charlottesville)"';
if [ "$OUTPUT" != "$EXPECTED" ]
then
    echo "ERROR: Legislator's formatted name isn't correct"
    ERRORED=true
fi

# If any tests failed, have this script return that failure
if [ "$ERRORED" == true ]; then
    exit 1
fi
