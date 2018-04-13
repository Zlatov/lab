#!/bin/bash
sqlite3 temp.sqlite3 < join.sql | while read response_line ex; do
  echo "$response_line"
done
