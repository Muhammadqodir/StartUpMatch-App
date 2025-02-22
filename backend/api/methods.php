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

function getFeed(DBHelper $db, $authUser)
{
  $posts = $db->readAllPitches();
  foreach ($posts as $key => $value) {
    $posts[$key]["owner"] = $db->readUser($value["owner"]);
  }
  return objResponse($posts);
}

function getNotifications(DBHelper $db, $authUser)
{
  $posts = $db->readAllNotificationsWhere("`user` = '" . $authUser["id"] . "'");
  // foreach ($posts as $key => $value) {
  //   $posts[$key]["owner"] = $db->readUser($value["owner"]);
  // }
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

function getMe(DBHelper $db, $authUser)
{
  return objResponse($authUser);
}

function removePitch(DBHelper $db, $authUser, $pitchId)
{
  $pitch = $db->readPitche($pitchId);
  if ($pitch == "Pitch not found") {
    return objResponse("Invalid pitch id");
  }
  if ($pitch["owner"]["id"] != $authUser["id"]) {
    return objResponse("Invalid pitch id");
  }

  $db->deletePitche($pitch["id"]);

  return objResponse([]);
}

function getMyPitches(DBHelper $db, $authUser)
{

  $pitches = $db->readAllPitchesWhere("`owner` = '" . $db->sanitize($authUser["id"]) . "'");

  foreach ($pitches as $key => $value) {
    $pitches[$key]["owner"] = $db->readUser($value["owner"]);
  }

  return objResponse($pitches);
}

function getMyChats(DBHelper $db, $authUser)
{
  $data = $db->getChats($authUser["id"]);
  $res = [];
  foreach ($data as $key => $value) {
    $res[] = [
      "user" => $db->readUser($value["to"]),
      "user1" => $db->readUser($value["from"]),
      "lastMessages" => [
        $db->readMessage($value["id"])
      ],
    ];
  }
  return objResponse($res);
}

function getMessages(DBHelper $db, $authUser, $cUserId)
{
  $messages = $db->readAllMessagesWhere(
    "(`to` = '" . $authUser["id"] . "' AND `from` = '" . $db->sanitize($cUserId) . "') OR (`to` = '" . $db->sanitize($cUserId) . "' AND `from` = '" . $authUser["id"] . "')"
  );
  foreach ($messages as $key => $value) {
    $messages[$key]["from"] = $db->readUser($value["from"]);
    $messages[$key]["to"] = $db->readUser($value["to"]);
  }

  return objResponse($messages);
}

function sendMessage(DBHelper $db, $authUser, $data, $files)
{
  if (empty($data["cUserId"])) {
    return objResponse("Error: to is required");
  }
  if (empty($data["message"])) {
    return objResponse("Error: message is required");
  }

  $attachmentUrl = "";
  if (!empty($files["attachment"]["name"])) {
    $uploadPath = "../uploads/";
    $file_name = generateToken(16);
    $fileType = pathinfo($files["attachment"]["name"], PATHINFO_EXTENSION);
    $imageUploadPath = $uploadPath . $file_name . '_attachment.' . $fileType;
    // Allow certain file formats 
    $allowTypes = array('jpg', 'png', 'jpeg');
    if (in_array($fileType, $allowTypes)) {
      // Image temp source and size 
      if (move_uploaded_file($files["attachment"]["tmp_name"], $imageUploadPath)) {
        $attachmentUrl = str_replace("../", "", $imageUploadPath);
      } else {
        return objResponse("Error: Sorry, there was an error uploading your file.");
      }
    } else {
      return objResponse("Error: Only jpg, jpeg, png files are allowed to upload.");
    }
  }

  $db->createMessage($data["message"], $attachmentUrl, $authUser["id"], $data["cUserId"], date('Y-m-d H:i:s'));

  return getMessages($db, $authUser, $data["cUserId"]);
}

function updateAccount(DBHelper $db, $authUser, $data)
{
  if (count($data) == 0) {
    return objResponse("No data to update");
  }

  $res = $db->updateUser($authUser["id"], $data);
  if ($res) {
    return objResponse($db->readUser($authUser["id"]));
  } else {
    return objResponse("Error updating user");
  }
}

function addLike(DBHelper $db, $authUser, $data)
{
  if (empty($data["pitchId"])) {
    return objResponse("Error: pitchId is required");
  }
  if (empty($data["action"])) {
    return objResponse("Error: action is required");
  }

  if ($data["action"] == "like") {
    $db->createLike($authUser["id"], date('Y-m-d H:i:s'), $data["pitchId"]);
  } else {
    $db->createDisLike($authUser["id"], date('Y-m-d H:i:s'), $data["pitchId"]);
  }

  return objResponse($db->readPitche($data["pitchId"]));
}

function addView(DBHelper $db, $authUser, $data)
{
  if (empty($data["pitchId"])) {
    return objResponse("Error: pitchId is required");
  }

  $db->createView($authUser["id"], date('Y-m-d H:i:s'), $data["pitchId"]);

  return objResponse($db->readPitche($data["pitchId"]));
}

function uploadUserPic($db, $authUser, $files)
{

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

      $db->updateUser($authUser["id"], ["pic" => $imageUrl]);
      return objResponse($db->readUser($authUser["id"]));
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
