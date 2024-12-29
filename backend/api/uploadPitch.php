<?php

require_once "validator.php";

function uploadPitch(DBHelper $db, $token, $data, $files)
{
  //validation
  $isValid = validate([
    validationField("title", "string"),
    validationField("description", "string"),
  ], $data);
  if ($isValid != "success") {
    return $isValid;
  }

  $users = $db->readAllUsersWhere("`token` = '" . $db->sanitize($token) . "'");
  if (count($users) == 0) {
    return objResponse("Invalid token");
  }
  $user = $users[0];

  $videoUrl = "";
  if (
    !empty($files["video"]["name"])
  ) {
    $file_name = generateRandomString();
    $uploadRes = uploadVideo($file_name, $files);
    if (str_contains($uploadRes, "Error:")) {
      return objResponse($uploadRes);
    }
    $videoUrl = $uploadRes;
  } else {
    return objResponse("Error: video is required");
  }

  $res = $db->createPitche($data["title"], $data["description"], $videoUrl, $user["id"], "[]", "[]", date("Y-m-d H:i:s"));
  if ($res) {
    return objResponse($db->readPitche($db->getLastInteredId()));
  } else {
    return objResponse("Error creating pitch");
  }
}



function uploadVideo($file_name, $files)
{
  $uploadPath = "../uploads/";
  $imageUploadPath = $uploadPath . $file_name . '_pitch.mp4';
  $fileType = pathinfo($files["video"]["name"], PATHINFO_EXTENSION);
  // Allow certain file formats 
  $allowTypes = array('mp4');
  if (in_array($fileType, $allowTypes)) {
    // Image temp source and size 
    if (move_uploaded_file($files["video"]["tmp_name"], $imageUploadPath)) {
      return str_replace("../", "", $imageUploadPath);;
    } else {
      return "Error: Sorry, there was an error uploading your file.";
    }
  } else {
    return "Error: Only MP4";
  }
}

function generateRandomString($length = 10)
{
  $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
  $charactersLength = strlen($characters);
  $randomString = '';

  for ($i = 0; $i < $length; $i++) {
    $randomString .= $characters[random_int(0, $charactersLength - 1)];
  }

  return $randomString;
}

