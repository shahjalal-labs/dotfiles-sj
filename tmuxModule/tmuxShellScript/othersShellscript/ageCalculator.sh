#!/usr/bin/env bash

# birth date (DD/MM/YYYY)
BIRTH="02/03/2003"

# convert birth date to unix timestamp
birth_ts=$(date -d "$(echo $BIRTH | awk -F/ '{print $3"-"$2"-"$1}')" +%s)

# current timestamp
now_ts=$(date +%s)

# difference in seconds
diff=$((now_ts - birth_ts))

years=$((diff / 31557600))
days=$(((diff % 31557600) / 86400))
hours=$(((diff % 86400) / 3600))
minutes=$(((diff % 3600) / 60))
seconds=$((diff % 60))

echo "Age from $BIRTH to now:"
echo "$years years $days days $hours hours $minutes minutes $seconds seconds"
