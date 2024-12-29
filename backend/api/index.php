<?php

ini_set('display_errors', '1');
ini_set('display_startup_errors', '1');
error_reporting(E_ALL);

require_once "../config.php";
require "../routing.php";
require "../db/db_helper.php";
require "methods.php";
require "uploadPitch.php";

$token = "undefined";
if (isset(apache_request_headers()["Authorization"])) {
  $token = apache_request_headers()["Authorization"];
}

$title = getCurrentRouteUtils();
$split = explode("/", $title);
$db = new DBHelper($host, $user, $password, $db);
header('Content-type: application/json');

$version = $split[1];
$method = $split[2];

$res = [
  "code" => 200,
  "data" => null,
  "message" => 200
];

switch ($method) {
  case 'register':
    httpResponse(register($db, $_POST));
    break;
  case 'login':
    httpResponse(login($db, $_POST));
    break;
  case 'getFeed':
    httpResponse(getFeed($db, $token));
    break;
  case 'uploadPitch':
    httpResponse(uploadPitch($db, $token, $_POST, $_FILES));
    break;
  case 'getMe':
    httpResponse(getMe($db, $token));
    break;
  case 'getMyPitches':
    httpResponse(getMyPitches($db, $token));
    break;
  case 'updateAccount':
    httpResponse(updateAccount($db, $token, $_POST));
    break;
  case 'uploadUserPic':
    httpResponse(uploadUserPic($db, $token, $_FILES));
    break;

  case 'removeAccount':
    httpResponse([
      "code" => 200,
      "data" => null,
      "message" => "ok"
    ]);
    break;
  default:
    httpResponse([
      "code" => 404,
      "data" => null,
      "message" => "method not found"
    ]);
}

function httpResponse($response)
{
  http_response_code($response["code"]);
  echo json_encode($response);
}
