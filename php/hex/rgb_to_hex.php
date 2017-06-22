<?php
function rgb_to_hex($rgb_arr) {
    if (!is_array($rgb_arr)||count($rgb_arr)!==3) {
        return '#FFFFFF';
    }
    $rgb = dechex(($rgb_arr[0]<<16)|($rgb_arr[1]<<8)|$rgb_arr[2]);
    return("#".substr("000000".$rgb, -6));
}

print_r(rgb_to_hex([255,3,1]));
echo PHP_EOL;
print_r(rgb_to_hex([0,255,0]));
echo PHP_EOL;
