<?php
ini_set('display_errors', '1');
ini_set('display_startup_errors', '1');
error_reporting(E_ALL);

require_once "config.php";
require_once "db/db_helper.php";

$db = new DBHelper($host, $user, $password, $db);

header('Content-type: application/json');
echo json_encode($db->readPitche(2));
