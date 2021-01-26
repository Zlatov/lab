<?php
    $template->assign_vars(array(
        'S_SOME_VARIABLE'   => $some_variable,
        'NOW'               => $user->format_date(time()),
       )
    );
?>

<div>{S_SOME_VARIABLE}<br />{NOW}</div>

<?php

    $log_files = [];
    foreach ($log_files as $value) {
        $template->assign_block_vars('log_files', ['NAME' => $value]);
    }

?>

<!-- IF .log_files -->
    <ul>
    <!-- BEGIN log_files -->
        <li>{log_files.NAME}</li>
    <!-- END log_files -->
    </ul>
<!-- ENDIF -->
