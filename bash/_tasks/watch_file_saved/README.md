```sh
sudo apt install inotify-tools
inotifywait --help
inotifywatch --help

cd ~/projects/my/lab/bash/_tasks/watch_file_saved
while inotifywait --event close_write --timeout 1 change_this_file.js; do echo 'Hi!'; done
```
