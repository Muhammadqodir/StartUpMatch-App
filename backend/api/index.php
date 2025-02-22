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

$authUser = "unautorized";
$dbRes = $db->readAllUsersWhere("`token` = '" . $db->sanitize($token) . "'");
if (count($dbRes) > 0) {
  $authUser = $dbRes[0];
}

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
    allowOnlyAuth();
    httpResponse(getFeed($db, $authUser));
    break;
  case 'getNotifications':
    allowOnlyAuth();
    httpResponse(getNotifications($db, $authUser));
    break;
  case 'uploadPitch':
    allowOnlyAuth();
    httpResponse(uploadPitch($db, $authUser, $_POST, $_FILES));
    break;
  case 'removePitch':
    allowOnlyAuth();
    httpResponse(removePitch($db, $authUser, $_GET["id"],));
    break;
  case 'getMe':
    allowOnlyAuth();
    httpResponse(getMe($db, $authUser));
    break;
  case 'getMyPitches':
    allowOnlyAuth();
    httpResponse(getMyPitches($db, $authUser));
    break;
  case 'getMyChats':
    allowOnlyAuth();
    httpResponse(getMyChats($db, $authUser));
    break;
  case 'getMessages':
    allowOnlyAuth();
    httpResponse(getMessages($db, $authUser, $_GET["cUserId"]));
    break;
  case 'sendMessage':
    allowOnlyAuth();
    httpResponse(sendMessage($db, $authUser, $_POST, $_FILES));
    break;
  case 'updateAccount':
    allowOnlyAuth();
    httpResponse(updateAccount($db, $authUser, $_POST));
    break;
  case 'uploadUserPic':
    allowOnlyAuth();
    httpResponse(uploadUserPic($db, $authUser, $_FILES));
    break;
  case 'addLike':
    allowOnlyAuth();
    httpResponse(addLike($db, $authUser, $_POST));
    break;
  case 'addView':
    allowOnlyAuth();
    httpResponse(addView($db, $authUser, $_GET));
    break;

  case 'removeAccount':
    allowOnlyAuth();
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

function allowOnlyAuth()
{
  global $authUser;
  if ($authUser == "unautorized") {
    httpResponse([
      "code" => 401,
      "data" => null,
      "message" => "Invalid token"
    ]);
    exit();
  }
}

function httpResponse($response)
{
  http_response_code($response["code"]);
  echo json_encode($response);
}
