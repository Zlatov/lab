<?php
namespace Zlatov;

include_once 'cli/CliInterface.php';

class Cli implements Cli\CliInterface
{
    public static function colored($string, $color = null)
    {
        return "\033[31m${string}\033[0m";
    }
}
