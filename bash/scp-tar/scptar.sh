# tar -czf images/* | (mkdir -p images2; cd images2; tar -xzf -)
# tar cf - . | ( cd /target; tar xfp -)

tar -cf - images/800* | (mkdir asdf; cd asdf; tar -xf -)
tar -cf - images/800* | ssh zenontest "tar -xf -"

tar -cf - ../images | ssh zenontest "cd ~/projects/forum/; tar -xf -"
tar -cf - ../upload | ssh zenontest "cd ~/projects/forum/; tar -xf -"
tar -cf - ../styles/prosilver/theme/fonts/robotocondensed/*.ttf | ssh zenontest "cd ~/projects/forum/; tar -xf -"
tar -cf - ../docs/assets/images | ssh zenontest "cd ~/projects/forum/; tar -xf -"
tar -cf - ../styles/prosilver/theme/images | ssh zenontest "cd ~/projects/forum/; tar -xf -"
tar -cf - ../styles/prosilver/theme/en/*.gif | ssh zenontest "cd ~/projects/forum/; tar -xf -"
tar -cf - ../styles/prosilver/theme/ru/*.gif | ssh zenontest "cd ~/projects/forum/; tar -xf -"


