<?php
// CREATE SCHEMA `tree` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
include_once 'config.php';
try {

    $dbh = new PDO('mysql:host=localhost;dbname=tree', $user, $password);
    // foreach($dbh->query('SELECT * from FOO') as $row) {
    //     print_r($row);
    // }

} catch (PDOException $e) {
    print "Error!: " . $e->getMessage() . "<br/>";
    die();
}







$dbh = null;
