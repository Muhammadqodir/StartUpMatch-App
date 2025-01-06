<?php


require_once "validator.php";


function register(DBHelper $db, $data)
{
  //validation
  $isValid = validate([
    validationField("fullName", "string"),
    validationField("email", "string"),
    validationField("userType", "string"),
    validationField("password", "string"),
  ], $data);
  if ($isValid != "success") {
    return $isValid;
  }
  if (count($db->readAllUsersWhere("`email` = '" . $db->sanitize($data["email"]) . "'")) != 0) {
    return objResponse("User with this email already exists");
  }
  $res = $db->createUser($data["fullName"], $data["email"], $data["userType"], "", date("Y-m-d H:i:s"), "", $data["password"], generateToken(32), "");
  if ($res) {
    return objResponse($db->readUser($db->getLastInteredId()));
  } else {
    return objResponse("Error creating user");
  }
}

function login(DBHelper $db, $data)
{
  //validation
  $isValid = validate([
    validationField("email", "string"),
    validationField("password", "string"),
  ], $data);
  if ($isValid != "success") {
    return $isValid;
  }
  $user = $db->readAllUsersWhere("`email` = '" . $db->sanitize($data["email"]) . "'");
  if (count($user) == 0) {
    return objResponse("User not found");
  }
  $user = $user[0];
  if ($user["password"] != $data["password"]) {
    return objResponse("Invalid password");
  }
  return objResponse($user);
}

function getFeed(DBHelper $db, $token)
{
  $user = $db->readAllUsersWhere("`token` = '" . $db->sanitize($token) . "'");
  if (count($user) == 0) {
    return objResponse("Invalid token");
  }
  $user = $user[0];
  $posts = $db->readAllPitches();
  foreach ($posts as $key => $value) {
    $posts[$key]["owner"] = $db->readUser($value["owner"]);
    $posts[$key]["likes"] = json_decode($value["likes"]);
    $posts[$key]["comments"] = json_decode($value["comments"]);
  }
  return objResponse($posts);
}


function generateToken($length)
{
  $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  $charactersLength = strlen($characters);
  $randomString = '';
  for ($i = 0; $i < $length; $i++) {
    $randomString .= $characters[rand(0, $charactersLength - 1)];
  }
  return $randomString;
}

function getMe(DBHelper $db, $token)
{
  $user = $db->readAllUsersWhere("`token` = '" . $db->sanitize($token) . "'");
  if (count($user) == 0) {
    return objResponse("Invalid token");
  }
  $user = $user[0];
  return objResponse($user);
}

function getMyPitches(DBHelper $db, $token)
{
  $user = $db->readAllUsersWhere("`token` = '" . $db->sanitize($token) . "'");
  if (count($user) == 0) {
    return objResponse("Invalid token");
  }
  $user = $user[0];
  $pitches = $db->readAllPitchesWhere("`user_id` = '" . $db->sanitize($user["id"]) . "'");
  return objResponse($pitches);
}

function updateAccount(DBHelper $db, $token, $data)
{
  if (count($data) == 0) {
    return objResponse("No data to update");
  }
  $user = $db->readAllUsersWhere("`token` = '" . $db->sanitize($token) . "'");
  if (count($user) == 0) {
    return objResponse("Invalid token");
  }
  $user = $user[0];

  $res = $db->updateUser($user["id"], $data);
  if ($res) {
    return objResponse($db->readUser($user["id"]));
  } else {
    return objResponse("Error updating user");
  }
}

function uploadUserPic($db, $token, $files)
{

  $user = $db->readAllUsersWhere("`token` = '" . $db->sanitize($token) . "'");
  if (count($user) == 0) {
    return objResponse("Invalid token:" . $token);
  }
  $user = $user[0];

  if (empty($files["image"]["name"])) {
    return objResponse("Error: image is required");
  }

  $uploadPath = "../uploads/";
  $file_name = generateToken(16);
  $fileType = pathinfo($files["image"]["name"], PATHINFO_EXTENSION);
  $imageUploadPath = $uploadPath . $file_name . '_user.' . $fileType;
  // Allow certain file formats 
  $allowTypes = array('jpg', 'png', 'jpeg');
  if (in_array($fileType, $allowTypes)) {
    // Image temp source and size 
    if (move_uploaded_file($files["image"]["tmp_name"], $imageUploadPath)) {
      $imageUrl = str_replace("../", "", $imageUploadPath);

      $db->updateUser($user["id"], ["pic" => $imageUrl]);
      return objResponse($db->readUser($user["id"]));
    } else {
      return objResponse("Error: Sorry, there was an error uploading your file.");
    }
  } else {
    return objResponse("Error: Only jpg, jpeg, png files are allowed to upload.");
  }
}


function objResponse($obj)
{
  if (gettype($obj) != "string") {
    return [
      "code" => 200,
      "message" => "ok",
      "data" => $obj
    ];
  } else {
    return [
      "code" => 403,
      "message" => $obj,
      "data" => null
    ];
  }
}
