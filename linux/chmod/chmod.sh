#!/usr/bin/env bash

exit 0

chmod u+x filename  # user         + execute (or access for directories)
chmod g+rw filename # group        + read,  write
chmod og-w filename # other, group - write
chmod a+r filename  # all          + read
