<?php
// exec('bash.sh');
$currentPath = getcwd();
// echo "<pre>";
// print_r($currentPath);
// echo "</pre>";
// die();
// $command = "DISPLAY=:0 gnome-terminal -e \"bash -c {$currentPath}/bash.sh;bash\"";
$command = "DISPLAY=:0 bash /home/iadfeshchm/projects/my/lab/lab/php/runBashInTerminal/script.sh";
$command = "DISPLAY=:0 bash /home/iadfeshchm/projects/my/lab/lab/php/runBashInTerminal/bash.sh";
// $command = "gnome-terminal -e 'sh -c ls;exec	bash'";
// $command = "gnome-terminal -e ls";
echo "<pre>";
print_r($command);
echo "</pre>";

$output = shell_exec($command);
echo "<pre>$output</pre>";
// exec('bash.sh');
