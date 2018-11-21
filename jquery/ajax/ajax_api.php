<?php
if (isset($_GET['action'])) {
    switch ($_GET['action']) {
        case 'hash':
            $ret = [
                "asd" => "asd",
                "zxc" => "zxc qwe",
            ];
            break;
        case 'array':
            $ret = [
                "asd",
                "zxc qwe",
            ];
            break;
        case 'post':
            $ret = [
                "name" => var_export($_POST["name"], true),
                "post" => var_export($_POST, true),
                "files" => var_export($_FILES, true),
            ];
            break;
        default:
            $ret = [];
            break;
    }
    header('Content-Type: application/json');
    echo json_encode($ret);
    exit(0);
}

echo '$_POST: <pre>';
print_r($_POST);
echo '</pre>';

echo '$_POST: <pre>';
var_export($_POST);
echo '</pre>';
