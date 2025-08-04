#!/bin/zsh

dir="/run/media/sj/developer/web/L1B11/1-amr-day-record/sessions"

# Force English locale for consistent formatting
day=$(LC_ALL=C date +%-d)
month_name=$(LC_ALL=C date +%B)
month_num=$(date +%-m)  # numeric month safe as is
year_short=$(date +%y)
weekday=$(LC_ALL=C date +%a)
time_now=$(LC_ALL=C date +"%-I:%M %p")
date_slug="$day-$month_num-$year_short"
folder="$dir/${month_name}${year_short}"
file="$folder/${date_slug}.md"

mkdir -p "$folder"

# If file doesn't exist, create with markdown header
if [[ ! -f "$file" ]]; then
  cat > "$file" <<EOF
# 📘 Personal Focus Sessions – Daily Log

This file tracks my focused sessions for **🗓️ $date_slug ($weekday)**
Each line represents a time I invoked my productivity ritual.

> ✨ Reminder: One focused breath at a time builds your day.

---

## ✅ Sessions

EOF
fi

# Get last session number
last_line_num=$(grep -E '^[0-9]+\.' "$file" | tail -n 1 | cut -d. -f1)
if [[ -z "$last_line_num" ]]; then
  next_line_num=1
else
  next_line_num=$((last_line_num + 1))
fi

# Append new session entry with fixed 10 minutes
echo "$next_line_num. $time_now $date_slug $weekday => 10 mnts" >> "$file"

# Count total sessions (lines containing '=> XX mnts')
session_count=$(grep -c '=> [0-9]\+ mnts' "$file")

# Calculate total minutes
total_mins=$((session_count * 10))

# Calculate hours and remaining minutes
hours=$((total_mins / 60))
mins=$((total_mins % 60))

# Format total time string
if (( hours > 0 )); then
  total_time="🕰️ Total: ${hours} hr"
  [[ $hours -gt 1 ]] && total_time+="s"
  [[ $mins -gt 0 ]] && total_time+=" ${mins} mnts"
else
  total_time="🕰️ Total: ${mins} mnts"
fi

# Remove previous total time line if it exists
sed -i '/^🕰️ Total:/d' "$file"

# Append updated total time line
echo "$total_time" >> "$file"

