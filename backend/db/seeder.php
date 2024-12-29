<?php

require "../config.php";
require "db_helper.php";

$db = new DBHelper($host, $user, $password, $db);

//Adding Categories to the database
echo $db->createList("category", "Technology", 0, "<i class=\"fa-solid fa-microchip\"></i>");
echo $db->createList("category", "Funny", 0, "<i class=\"fa-solid fa-face-smile\"></i>");
echo $db->createList("category", "Entertainment", 0, "<i class=\"fa-solid fa-face-grin-stars\"></i>");

//Adding Platforms to the database
echo $db->createList("platform", "YouTube", 0, "<i class=\"fa-brands fa-youtube\"></i>");
echo $db->createList("platform", "Instagram", 0, "<i class=\"fa-brands fa-instagram\"></i>");
echo $db->createList("platform", "Twitter", 0, "<i class=\"fa-brands fa-twitter\"></i>");


echo "Done!";