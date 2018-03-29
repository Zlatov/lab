#!/bin/bash
sqlite3 temp.sqlite3 < table.sql | while read response_line ex; do
  echo "$response_line"
done
