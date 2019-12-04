#!/usr/bin/env bash

# Is basic bill metadata being displayed?
if ! curl --no-buffer --silent "http://localhost:5000/bill/2019/sb1604/" |grep -q "<h1>Cruelty to animals"
then
    echo "ERROR: Basic bill metadata isn't being displayed"
    ERRORED=true
fi

# Is bill text being displayed?
if ! curl --no-buffer --silent "http://localhost:5000/bill/2019/sb1604/fulltext/" |grep -q "agricultural animal"
then
    echo "ERROR: Bill text isn't being displayed"
    ERRORED=true
fi

# Are bill comments being displayed?
if ! curl --no-buffer --silent "http://localhost:5000/bill/2019/sb1604/" |grep -q "gruesome"
then
    echo "ERROR: Bill comments aren't being displayed"
    ERRORED=true
fi

# Are bill poll results being displayed?
if ! curl --no-buffer --silent "http://localhost:5000/bill/2019/sb1604/" |grep -q "55 votes"
then
    echo "ERROR: Bill poll results aren't being displayed"
    ERRORED=true
fi

# Are bill outcomes displayed?
if ! curl --no-buffer --silent "http://localhost:5000/bill/2019/sb1604/" |grep -q "Bill Has Passed"
then
    echo "ERROR: Bill outcomes aren't being displayed"
    ERRORED=true
fi

# Are bill histories displayed?
if ! curl --no-buffer --silent "http://localhost:5000/bill/2019/sb1604/" |grep -q "Rereferred to Finance"
then
    echo "ERROR: Bill histories aren't being displayed"
    ERRORED=true
fi

# Are bill co-sponsors listed?
if ! curl --no-buffer --silent "http://localhost:5000/bill/2019/hb2491/" |grep -q "with support from co-patrons"
then
    echo "ERROR: Bill copatrons aren't being displayed for HB2491"
    ERRORED=true
fi

# Are poll results displayed?
if ! curl --no-buffer --silent "http://localhost:5000/bill/2019/hb2491/" |grep -q "32 votes"
then
    echo "ERROR: Bill copatrons aren't being displayed for HB2491"
    ERRORED=true
fi

# Is basic legislator information being displayed?
if ! curl --no-buffer --silent "http://localhost:5000/legislator/lradams/" |grep -q "<h1>Del. Les Adams"
then
    echo "ERROR: Basic legislator information isn't being displayed"
    ERRORED=true
fi

# Are the newest comments displayed on the home page?
if [ "$(curl --no-buffer --silent "http://localhost:5000//" |grep -c "#comment-")" -ne 6 ]
then
    echo "ERROR: Basic legislator information isn't being displayed"
    ERRORED=true
fi

# Are committee pages working?
if ! curl --no-buffer --silent "http://localhost:5000/committee/house/finance/" |grep -q "<h1>House Finance Committee"
then
    echo "ERROR: The House Finance committee page doesn't work"
    ERRORED=true
fi

# Are committee members listed?
# This is not a great test. We're using the presence of a committee chair as a proxy for whether
# members are listed at all, because there's no practical way to separate that out from the menu
# list of legislators.
if ! curl --no-buffer --silent "http://localhost:5000/committee/house/finance/" |grep -q "Chair"
then
    echo "ERROR: House Finance committee members aren't listed"
    ERRORED=true
fi

# Are subcommittees listed?
if ! curl --no-buffer --silent "http://localhost:5000/committee/house/finance/" |grep -q "Subcommittee "
then
    echo "ERROR: House Finance subcommittees aren't listed"
    ERRORED=true
fi

# Are legislative hearings listed for bills?
if ! curl --no-buffer --silent "http://localhost:5000/schedule/2019/01/15/" |grep -q "SB1038"
then
    echo "ERROR: SB1038 isn't listed on the schedule for 2019-01-15"
    ERRORED=true
fi

# If any tests failed, have this script return that failure
if [ "$ERRORED" == true ]; then
    exit 1
fi
