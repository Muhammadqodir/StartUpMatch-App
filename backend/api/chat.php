<?php

function getMyChats(DBHelper $db, $token)
{
  $user = $db->readAllUsersWhere("`token` = '" . $db->sanitize($token) . "'");
  if (count($user) == 0) {
    return objResponse("Invalid token");
  }
  $user = $user[0];
  $chats = $db->readAllChatsWhere('`user0` = ' . $user["id"] . ' OR `user1` = ' . $user["id"]);
  foreach ($chats as $key => $value) {
    $chats[$key]["user0"] = $db->readUser($value["user0"]);
    $chats[$key]["user1"] = $db->readUser($value["user1"]);
  }
  return objResponse($chats);
}

function getMessages(DBHelper $db, $token, $chatId)
{
  $user = $db->readAllUsersWhere("`token` = '" . $db->sanitize($token) . "'");
  if (count($user) == 0) {
    return objResponse("Invalid token");
  }
  $user = $user[0];

  $messages = $db->readAllMessagesWhere("`chat_id` = '" . $db->sanitize($chatId) . "'");
  return objResponse($messages);
}
