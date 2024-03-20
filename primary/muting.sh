#!/bin/sh
#example Linux shell script to mute all synthetic test alerts during a defined window every day
#This muting example is limited to muting synthetic tests by using the "test_type" field to filter by api, browser, http, and port
#Example crontab entry to create this muting rule every day at 12:15AM
#15 0 * * * /path/to/this/script.sh
#The muting rule will automatically disappear after it expires
#O11y Cloud uses UTC, so adjust according to your time zone. For example, to specify 2AM ET, use "00:00 today + 6 hours"
# SPLUNK_ALERT_MUTE_START=$(date -d "00:00 today + 6 hours" +%s%3N)
# SPLUNK_ALERT_MUTE_STOP=$(date -d "00:00 today + 8 hours" +%s%3N)
SPLUNK_ALERT_MUTE_START=0
SPLUNK_ALERT_MUTE_STOP=0
#put a valid API token value here. hint: don't use an ingest token ;)
SPLUNK_API_TOKEN=""

#Create catch all detector muting rule
#curl -X "POST" "https://api.us1.signalfx.com/v2/alertmuting" -H "Content-Type: application/json" -H "X-SF-TOKEN: $SPLUNK_API_TOKEN" -d '{"description": "mute all detectors","filters": [{"NOT": true,"property":"muteall","propertyValue":["muteall"]}],"sendAlertsOnceMutingPeriodHasEnded":false,"startTime":'$SPLUNK_ALERT_MUTE_START',"stopTime":'$SPLUNK_ALERT_MUTE_STOP'}'
#The newly created muting rule will appear in O11y Cloud interface under "Alerts & Detectors" -> "Muting Rules"

#Fetch all muting rules
#curl -X "GET" "https://api.us1.signalfx.com/v2/alertmuting" -H "Content-Type: application/json" -H "X-SF-TOKEN: $SPLUNK_API_TOKEN"

#Stop muting rule
#curl -X "PUT" "https://api.us1.signalfx.com/v2/alertmuting/GJFimNUA4AE/unmute" -H "Content-Type: application/json" -H "X-SF-TOKEN: $SPLUNK_API_TOKEN"

