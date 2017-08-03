<?php
// $_SERVER['REMOTE_ADDR'], остальное - фуфло. 
// Все что начинается с $_SERVER['HTML_... - это заголовки, их можно подделать!
// Бред:
// function getIP() {
//     if (getenv("HTTP_CLIENT_IP"))
//         $ip = getenv("HTTP_CLIENT_IP");
//     else if(getenv("HTTP_X_FORWARDED_FOR"))
//         $ip = getenv("HTTP_X_FORWARDED_FOR");
//     else if(getenv("REMOTE_ADDR"))
//         $ip = getenv("REMOTE_ADDR");
//     else
//         $ip = "UNKNOWN";
//     return $ip;
// }
// $client_ip=getIP();
// echo "Your IP :".$client_ip;

$ip = '1.2.1.1';

$array = [
    '*.*.*.*',
    '1.*.*.*',
    '1.1.*.*',
    '1.1.1.*',

    '1.1.1.1',

    '1.*.*.1',
    '1.1.*.1',
    '1.*.1.1',
    '1.*.1.*',
];

foreach ($array as $network) {
    $return = mask_contains_ip($network, $ip);

    echo "<pre>";
    printf(
        "( %+15s & %+15s ) %+15s",
        $network,
        $ip,
        $return
    );
    echo "</pre>";
}

function mask_contains_ip($network, $ip)
{
    $return = false;
    $position_star = 0;
    $x = 32;
    if (strpos($network, '*') !== FALSE) {
        if (preg_match('/\*\.\d+/',$network)) {
            $array = explode('.',$network);
            $ip_parts = explode('.',$ip);
            $network = [];
            $end_of_mask_is_true = true;
            foreach ($array as $key => $value) {
                if ($value === '*' && !$position_star) {
                    $position_star = $key +1;
                }
                $network[] = $position_star?'0':$value;
                if ($position_star && ($key + 1) > $position_star && $value !== '*') {
                    if ($value !== $ip_parts[$key]) {
                        $end_of_mask_is_true = false;
                    }
                }
            }
            $network = implode($network, '.');
            if ($position_star === 2) {
                $network .= '/8';
            } else if ($position_star === 3) {
                $network .= '/16';
            }
            $ip_arr = explode('/', $network);
            $network = $ip_arr[0];
            $x = $ip_arr[1];

            list ($subnet, $bits) = explode('/', $network.'/'.$x);
            $ip_long = ip2long($ip);
            $subnet = ip2long($subnet);
            $mask = -1 << (32 - $bits);
            $subnet &= $mask; # nb: in case the supplied subnet wasn't correctly aligned
            $return = (($ip_long & $mask) == $subnet);
            return $return && $end_of_mask_is_true;

        } else {
            $nCount = substr_count($network, '*');
            $network = str_replace('*', '0', $network);
            if ($nCount == 1) {
                $network .= '/24';
            } else if ($nCount == 2) {
                $network .= '/16';
            } else if ($nCount == 3) {
                $network .= '/8';
            } else if ($nCount > 3) {
                $network .= '/0';
            }
            $ip_arr = explode('/', $network);
            $network = $ip_arr[0];
            $x = $ip_arr[1];
        }
    } else {
        $network = $network;
        $x = $x;
    }

    list ($subnet, $bits) = explode('/', $network.'/'.$x);
    $ip_long = ip2long($ip);
    $subnet = ip2long($subnet);
    $mask = -1 << (32 - $bits);
    $subnet &= $mask; # nb: in case the supplied subnet wasn't correctly aligned
    return (($ip_long & $mask) == $subnet);
}

// $ip2 = '1.1.1.255';
// $mask2 = '1.1.1.0/32';

// list($subnet, $bits) = explode('/', $mask2);
// $ip_long = ip2long($ip2);

// $subnet = ip2long($subnet);
// $mask = -1 << (32 - $bits);
// $subnet &= $mask; # nb: in case the supplied subnet wasn't correctly aligned
// $return = (($ip_long & $mask) == $subnet);

// echo "<pre>";
// printf('%+15s %+15s %+15s %+15s %+15s %+15s %+15s',$ip2,$mask2,$ip_long,$mask, $ip_long & $mask, $subnet, $return);
// echo "</pre>";
// die();
