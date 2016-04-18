<?php
// error_reporting(-1);
$errLvl = error_reporting();
for ($i = 0; $i < 15;  $i++ ) {
    print FriendlyErrorType($errLvl & pow(2, $i)) . "<br>\n";
}

function FriendlyErrorType($type)
{
    switch($type)
    {
        case E_ERROR: // 1 //
            return 'E_ERROR - Фатальные ошибки (ошибка распределения памяти и т.п.)';
        case E_WARNING: // 2 //
            return 'E_WARNING - Предупреждения';
        case E_PARSE: // 4 //
            return 'E_PARSE - Ошибки на этапе компиляции';
        case E_NOTICE: // 8 //
            return 'E_NOTICE - Уведомления (произошло что-то, что может указывать на ошибку, может стать ошибкой)';
        case E_CORE_ERROR: // 16 //
            return 'E_CORE_ERROR - Фатальные ошибки';
        case E_CORE_WARNING: // 32 //
            return 'E_CORE_WARNING - Предупреждения';
        case E_COMPILE_ERROR: // 64 //
            return 'E_COMPILE_ERROR - Фатальные ошибки на этапе компиляции';
        case E_COMPILE_WARNING: // 128 //
            return 'E_COMPILE_WARNING - Предупреждения на этапе компиляции (не фатальные ошибки)';
        case E_USER_ERROR: // 256 //
            return 'E_USER_ERROR - Сообщения об ошибках сгенерированные пользователем';
        case E_USER_WARNING: // 512 //
            return 'E_USER_WARNING - Предупреждения сгенерированные пользователем.';
        case E_USER_NOTICE: // 1024 //
            return 'E_USER_NOTICE - Уведомления сгенерированные пользователем.';
        case E_STRICT: // 2048 //
            return 'E_STRICT - Предлагается изменения в коде, которые обеспечат лучшее взаимодействие и совместимость кода';
        case E_RECOVERABLE_ERROR: // 4096 //
            return 'E_RECOVERABLE_ERROR - Фатальные ошибки с возможностью обработки (отлова)';
        case E_DEPRECATED: // 8192 //
            return 'E_DEPRECATED - Использовании устаревших конструкций';
        case E_USER_DEPRECATED: // 16384 //
            return 'E_USER_DEPRECATED - использовании устаревших конструкций, ошибки сгенерированные пользователем';
    }
    return "";
} 