#!/bin/bash
# script to scan /srv/mirror_data
echo "Scan of /srv/mirror_data started at `date --rfc-3339=s`" >> /var/log/clamav/clamdscan.log
/usr/bin/clamdscan --quiet -l /var/log/clamav/clamdscan.log --move /srv/infected /srv/mirror_data
