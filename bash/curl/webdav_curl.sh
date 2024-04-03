#!/usr/bin/env bash

set -eu

exit 0


https://help.ubuntu.ru/wiki/davfs2

To delete files in the target, add the --delete option to your command. For example:
rsync -avh source/ dest/ --delete
NB: -avh is for --archive --verbose --human-readable
