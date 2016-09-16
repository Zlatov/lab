<?php
// CREATE SCHEMA `tree` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
// 
// CREATE TABLE `tree`.`ct_tree` (
//   `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
//   `header` VARCHAR(45) CHARACTER SET 'utf8' COLLATE 'utf8_general_ci' NOT NULL,
//   PRIMARY KEY (`id`));

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
