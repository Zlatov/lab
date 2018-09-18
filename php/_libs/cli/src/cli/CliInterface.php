<?php
namespace Zlatov\Cli;

interface CliInterface
{
    /**
     * Возвращает строку подсвеченную в баш консоли.
     * @param  String $string подсвечиваемая строка
     * @param  String $color  строковый идентификатор цвета сиволов
     * @return String         строка с подсветкой
     */
    public static function colored($string, $color = null);
}
