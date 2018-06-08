#!/bin/bash
printf "echo '1'\necho '2'\necho '3'" | xargs -n1 -P3 -I{} /usr/bin/my-process-{} --args{}
echo 'hi'
