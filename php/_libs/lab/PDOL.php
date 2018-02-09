<?php
namespace Lab;

class PDOL {

  function __construct() {
    $user = 'lab';
    $host = 'localhost';
    $password = 'lab';
    $dbname = 'lab';
    $charset = 'utf8';
    $opt = [
      \PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION,
      // \PDO::ATTR_ERRMODE - Режим сообщений об ошибках.
      // \PDO::ERRMODE_EXCEPTION - Выбрасывать исключения.
      \PDO::ATTR_DEFAULT_FETCH_MODE => \PDO::FETCH_ASSOC,
      // \PDO::ATTR_DEFAULT_FETCH_MODE - Задает режим выборки данных по умолчанию.
      // \PDO::FETCH_ASSOC: возвращает массив, индексированный именами столбцов результирующего набора.
      \PDO::ATTR_EMULATE_PREPARES => false, // За обработку подготовленных выражений отвечает сам PDO.
      \PDO::ATTR_STRINGIFY_FETCHES => false // Преобразовывать числовые значения в строки во время выборки.
    ];
    $pdo = new \PDO("mysql:host=$host;dbname=$dbname;charset=$charset", $user, $password, $opt);
    return $pdo;
  }

  public static function connect() {
    $user = 'lab';
    $host = 'localhost';
    $password = 'lab';
    $dbname = 'lab';
    $charset = 'utf8';
    $opt = [
      \PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION,
      // \PDO::ATTR_ERRMODE - Режим сообщений об ошибках.
      // \PDO::ERRMODE_EXCEPTION - Выбрасывать исключения.
      \PDO::ATTR_DEFAULT_FETCH_MODE => \PDO::FETCH_ASSOC,
      // \PDO::ATTR_DEFAULT_FETCH_MODE - Задает режим выборки данных по умолчанию.
      // \PDO::FETCH_ASSOC: возвращает массив, индексированный именами столбцов результирующего набора.
      \PDO::ATTR_EMULATE_PREPARES => false, // За обработку подготовленных выражений отвечает сам PDO.
      \PDO::ATTR_STRINGIFY_FETCHES => false // Преобразовывать числовые значения в строки во время выборки.
    ];
    $pdo = new \PDO("mysql:host=$host;dbname=$dbname;charset=$charset", $user, $password, $opt);
    return $pdo;
  }

}
