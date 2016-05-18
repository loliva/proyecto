#!/bin/sh

texto=${MONIT_DESCRIPTION};
host=${MONIT_HOST};
process=${MONIT_SERVICE};

curl -X POST --data-urlencode "payload={\"attachments\":[{\"fallback\":\"MONIT: ${texto}\",\"text\":\"MONIT: ${texto}\",\"color\":\"danger\",\"fields\":[{\"title\":\"host\",\"value\":\"${host}\",\"short\":true},{\"title\":\"process\",\"value\":\"${process}\",\"short\":true}]}]}" https://hooks.slack.com/services/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
