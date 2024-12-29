<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require "../config.php";
require "../utils/routing.php";
require "db_helper.php";

$db = new DBHelper($host, $user, $password, $db);

echo "ok";

print_r($db->readAllListsWhere("`type` = 'platform'"));

echo "great123456789";
