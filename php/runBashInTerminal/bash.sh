#!/bin/bash
ls -la
whoami
gnome-terminal --window-with-profile=iadfeshchm
gnome-terminal -e "bash ls;bash"
gnome-terminal -x bash -c "ls;bash"
# gnome-terminal -e "bash -c /home/iadfeshchm/projects/my/lab/lab/php/runBashInTerminal/script.sh;bash" --window-with-profile=iadfeshchm
