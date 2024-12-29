<?php

class DBHelper
{
  private $mysqli;

  public function __construct($host, $user, $password, $db)
  {
    $this->mysqli = new mysqli($host, $user, $password, $db);
    $this->mysqli->set_charset("utf8");
    $this->mysqli->options(MYSQLI_OPT_INT_AND_FLOAT_NATIVE, true);

    if ($this->mysqli->connect_errno) {
      echo "Failed to connect to MySQL: " . $this->mysqli->connect_error;
      exit();
    }
  }

  public function getLastInteredId()
  {
    return $this->mysqli->insert_id;
  }

  public function sanitize($string)
  {
    return $this->mysqli->real_escape_string($string);
  }

  public function createUser($fullName, $email, $userType, $pic, $joined, $location, $password, $token)
  {
    $stmt = $this->mysqli->prepare("INSERT INTO `users` (`fullName`, `email`, `userType`, `pic`, `joined`, `location`, `password`, `token`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("ssssssss", $fullName, $email, $userType, $pic, $joined, $location, $password, $token);
    return $stmt->execute();
  }

  public function readAllUsers()
  {
    $query = "SELECT * FROM `users`";
    $result = $this->mysqli->query($query);
    if ($result) {
      $data = [];
      while ($row = $result->fetch_assoc()) {
        $data[] = $row;
      }
      return $data;
    } else {
      echo "Error: " . $this->mysqli->error;
      return [];
    }
  }

  public function readAllUsersWhere($condition)
  {
    $query = "SELECT * FROM `users` WHERE $condition";
    $result = $this->mysqli->query($query);
    if ($result) {
      $data = [];
      while ($row = $result->fetch_assoc()) {
        $data[] = $row;
      }
      return $data;
    } else {
      echo "Error: " . $this->mysqli->error;
      return [];
    }
  }

  public function readUser($id)
  {
    $stmt = $this->mysqli->prepare("SELECT * FROM `users` WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result->fetch_assoc();
  }

  public function updateUser($id, $data)
  {
    $set = implode(", ", array_map(function ($key) {
      return "`$key` = ?";
    }, array_keys($data)));
    $stmt = $this->mysqli->prepare("UPDATE `users` SET $set WHERE id = ?");
    $types = str_repeat('s', count($data)) . 'i';
    $values = array_values($data);
    $values[] = $id;
    $stmt->bind_param($types, ...$values);
    return $stmt->execute();
  }

  public function deleteUser($id)
  {
    $stmt = $this->mysqli->prepare("DELETE FROM `users` WHERE id = ?");
    $stmt->bind_param("i", $id);
    return $stmt->execute();
  }

  public function createNotification($user, $title, $content, $icon)
  {
    $stmt = $this->mysqli->prepare("INSERT INTO `notifications` (`user`, `title`, `content`, `icon`) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssss", $user, $title, $content, $icon);
    return $stmt->execute();
  }

  public function readAllNotifications()
  {
    $query = "SELECT * FROM `notifications`";
    $result = $this->mysqli->query($query);
    if ($result) {
      $data = [];
      while ($row = $result->fetch_assoc()) {
        $data[] = $row;
      }
      return $data;
    } else {
      echo "Error: " . $this->mysqli->error;
      return [];
    }
  }

  public function readAllNotificationsWhere($condition)
  {
    $query = "SELECT * FROM `notifications` WHERE $condition";
    $result = $this->mysqli->query($query);
    if ($result) {
      $data = [];
      while ($row = $result->fetch_assoc()) {
        $data[] = $row;
      }
      return $data;
    } else {
      echo "Error: " . $this->mysqli->error;
      return [];
    }
  }

  public function readNotification($id)
  {
    $stmt = $this->mysqli->prepare("SELECT * FROM `notifications` WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result->fetch_assoc();
  }

  public function updateNotification($id, $data)
  {
    $set = implode(", ", array_map(function ($key) {
      return "`$key` = ?";
    }, array_keys($data)));
    $stmt = $this->mysqli->prepare("UPDATE `notifications` SET $set WHERE id = ?");
    $types = str_repeat('s', count($data)) . 'i';
    $values = array_values($data);
    $values[] = $id;
    $stmt->bind_param($types, ...$values);
    return $stmt->execute();
  }

  public function deleteNotification($id)
  {
    $stmt = $this->mysqli->prepare("DELETE FROM `notifications` WHERE id = ?");
    $stmt->bind_param("i", $id);
    return $stmt->execute();
  }

  public function createLike($author, $date, $target)
  {
    $stmt = $this->mysqli->prepare("INSERT INTO `likes` (`author`, `date`, `target`) VALUES (?, ?, ?)");
    $stmt->bind_param("sss", $author, $date, $target);
    return $stmt->execute();
  }

  public function readAllLikes()
  {
    $query = "SELECT * FROM `likes`";
    $result = $this->mysqli->query($query);
    if ($result) {
      $data = [];
      while ($row = $result->fetch_assoc()) {
        $data[] = $row;
      }
      return $data;
    } else {
      echo "Error: " . $this->mysqli->error;
      return [];
    }
  }

  public function readAllLikesWhere($condition)
  {
    $query = "SELECT * FROM `likes` WHERE $condition";
    $result = $this->mysqli->query($query);
    if ($result) {
      $data = [];
      while ($row = $result->fetch_assoc()) {
        $data[] = $row;
      }
      return $data;
    } else {
      echo "Error: " . $this->mysqli->error;
      return [];
    }
  }

  public function readLike($id)
  {
    $stmt = $this->mysqli->prepare("SELECT * FROM `likes` WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result->fetch_assoc();
  }

  public function updateLike($id, $data)
  {
    $set = implode(", ", array_map(function ($key) {
      return "`$key` = ?";
    }, array_keys($data)));
    $stmt = $this->mysqli->prepare("UPDATE `likes` SET $set WHERE id = ?");
    $types = str_repeat('s', count($data)) . 'i';
    $values = array_values($data);
    $values[] = $id;
    $stmt->bind_param($types, ...$values);
    return $stmt->execute();
  }

  public function deleteLike($id)
  {
    $stmt = $this->mysqli->prepare("DELETE FROM `likes` WHERE id = ?");
    $stmt->bind_param("i", $id);
    return $stmt->execute();
  }

  public function createPitche($title, $description, $videoUrl, $owner, $likes, $comments, $date)
  {
    $stmt = $this->mysqli->prepare("INSERT INTO `pitches` (`title`, `description`, `videoUrl`, `owner`, `likes`, `comments`, `date`) VALUES (?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("sssssss", $title, $description, $videoUrl, $owner, $likes, $comments, $date);
    return $stmt->execute();
  }

  public function readAllPitches()
  {
    $query = "SELECT * FROM `pitches`";
    $result = $this->mysqli->query($query);
    if ($result) {
      $data = [];
      while ($row = $result->fetch_assoc()) {
        $row["owner"] = $this->readUser($row["owner"]);
        $row["likes"] = json_decode($row["likes"]);
        $row["comments"] = json_decode($row["comments"]);
        $data[] = $row;
      }
      return $data;
    } else {
      echo "Error: " . $this->mysqli->error;
      return [];
    }
  }

  public function readAllPitchesWhere($condition)
  {
    $query = "SELECT * FROM `pitches` WHERE $condition";
    $result = $this->mysqli->query($query);
    if ($result) {
      $data = [];
      while ($row = $result->fetch_assoc()) {
        $row["owner"] = $this->readUser($row["owner"]);
        $row["likes"] = json_decode($row["likes"]);
        $row["comments"] = json_decode($row["comments"]);
        $data[] = $row;
      }
      return $data;
    } else {
      echo "Error: " . $this->mysqli->error;
      return [];
    }
  }

  public function readPitche($id)
  {
    $stmt = $this->mysqli->prepare("SELECT * FROM `pitches` WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    $row = $result->fetch_assoc();
    $row["owner"] = $this->readUser($row["owner"]);
    $row["likes"] = json_decode($row["likes"]);
    $row["comments"] = json_decode($row["comments"]);
    return $row;
  }

  public function updatePitche($id, $data)
  {
    $set = implode(", ", array_map(function ($key) {
      return "`$key` = ?";
    }, array_keys($data)));
    $stmt = $this->mysqli->prepare("UPDATE `pitches` SET $set WHERE id = ?");
    $types = str_repeat('s', count($data)) . 'i';
    $values = array_values($data);
    $values[] = $id;
    $stmt->bind_param($types, ...$values);
    return $stmt->execute();
  }

  public function deletePitche($id)
  {
    $stmt = $this->mysqli->prepare("DELETE FROM `pitches` WHERE id = ?");
    $stmt->bind_param("i", $id);
    return $stmt->execute();
  }

  public function createChat($user0, $user1)
  {
    $stmt = $this->mysqli->prepare("INSERT INTO `chats` (`user0`, `user1`) VALUES (?, ?)");
    $stmt->bind_param("ss", $user0, $user1);
    return $stmt->execute();
  }

  public function readAllChats()
  {
    $query = "SELECT * FROM `chats`";
    $result = $this->mysqli->query($query);
    if ($result) {
      $data = [];
      while ($row = $result->fetch_assoc()) {
        $data[] = $row;
      }
      return $data;
    } else {
      echo "Error: " . $this->mysqli->error;
      return [];
    }
  }

  public function readAllChatsWhere($condition)
  {
    $query = "SELECT * FROM `chats` WHERE $condition";
    $result = $this->mysqli->query($query);
    if ($result) {
      $data = [];
      while ($row = $result->fetch_assoc()) {
        $data[] = $row;
      }
      return $data;
    } else {
      echo "Error: " . $this->mysqli->error;
      return [];
    }
  }

  public function readChat($id)
  {
    $stmt = $this->mysqli->prepare("SELECT * FROM `chats` WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result->fetch_assoc();
  }

  public function updateChat($id, $data)
  {
    $set = implode(", ", array_map(function ($key) {
      return "`$key` = ?";
    }, array_keys($data)));
    $stmt = $this->mysqli->prepare("UPDATE `chats` SET $set WHERE id = ?");
    $types = str_repeat('s', count($data)) . 'i';
    $values = array_values($data);
    $values[] = $id;
    $stmt->bind_param($types, ...$values);
    return $stmt->execute();
  }

  public function deleteChat($id)
  {
    $stmt = $this->mysqli->prepare("DELETE FROM `chats` WHERE id = ?");
    $stmt->bind_param("i", $id);
    return $stmt->execute();
  }

  public function createComment($author, $comment, $date)
  {
    $stmt = $this->mysqli->prepare("INSERT INTO `comments` (`author`, `comment`, `date`) VALUES (?, ?, ?)");
    $stmt->bind_param("sss", $author, $comment, $date);
    return $stmt->execute();
  }

  public function readAllComments()
  {
    $query = "SELECT * FROM `comments`";
    $result = $this->mysqli->query($query);
    if ($result) {
      $data = [];
      while ($row = $result->fetch_assoc()) {
        $data[] = $row;
      }
      return $data;
    } else {
      echo "Error: " . $this->mysqli->error;
      return [];
    }
  }

  public function readAllCommentsWhere($condition)
  {
    $query = "SELECT * FROM `comments` WHERE $condition";
    $result = $this->mysqli->query($query);
    if ($result) {
      $data = [];
      while ($row = $result->fetch_assoc()) {
        $data[] = $row;
      }
      return $data;
    } else {
      echo "Error: " . $this->mysqli->error;
      return [];
    }
  }

  public function readComment($id)
  {
    $stmt = $this->mysqli->prepare("SELECT * FROM `comments` WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result->fetch_assoc();
  }

  public function updateComment($id, $data)
  {
    $set = implode(", ", array_map(function ($key) {
      return "`$key` = ?";
    }, array_keys($data)));
    $stmt = $this->mysqli->prepare("UPDATE `comments` SET $set WHERE id = ?");
    $types = str_repeat('s', count($data)) . 'i';
    $values = array_values($data);
    $values[] = $id;
    $stmt->bind_param($types, ...$values);
    return $stmt->execute();
  }

  public function deleteComment($id)
  {
    $stmt = $this->mysqli->prepare("DELETE FROM `comments` WHERE id = ?");
    $stmt->bind_param("i", $id);
    return $stmt->execute();
  }

  public function createAnnouncement($content, $image, $title, $link, $btnTitle, $owner, $likes, $comments, $date)
  {
    $stmt = $this->mysqli->prepare("INSERT INTO `announcements` (`content`, `image`, `title`, `link`, `btnTitle`, `owner`, `likes`, `comments`, `date`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("sssssssss", $content, $image, $title, $link, $btnTitle, $owner, $likes, $comments, $date);
    return $stmt->execute();
  }

  public function readAllAnnouncements()
  {
    $query = "SELECT * FROM `announcements`";
    $result = $this->mysqli->query($query);
    if ($result) {
      $data = [];
      while ($row = $result->fetch_assoc()) {
        $data[] = $row;
      }
      return $data;
    } else {
      echo "Error: " . $this->mysqli->error;
      return [];
    }
  }

  public function readAllAnnouncementsWhere($condition)
  {
    $query = "SELECT * FROM `announcements` WHERE $condition";
    $result = $this->mysqli->query($query);
    if ($result) {
      $data = [];
      while ($row = $result->fetch_assoc()) {
        $data[] = $row;
      }
      return $data;
    } else {
      echo "Error: " . $this->mysqli->error;
      return [];
    }
  }

  public function readAnnouncement($id)
  {
    $stmt = $this->mysqli->prepare("SELECT * FROM `announcements` WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result->fetch_assoc();
  }

  public function updateAnnouncement($id, $data)
  {
    $set = implode(", ", array_map(function ($key) {
      return "`$key` = ?";
    }, array_keys($data)));
    $stmt = $this->mysqli->prepare("UPDATE `announcements` SET $set WHERE id = ?");
    $types = str_repeat('s', count($data)) . 'i';
    $values = array_values($data);
    $values[] = $id;
    $stmt->bind_param($types, ...$values);
    return $stmt->execute();
  }

  public function deleteAnnouncement($id)
  {
    $stmt = $this->mysqli->prepare("DELETE FROM `announcements` WHERE id = ?");
    $stmt->bind_param("i", $id);
    return $stmt->execute();
  }

  public function createMessage($content, $media, $from, $to, $time, $readTime, $chat_id)
  {
    $stmt = $this->mysqli->prepare("INSERT INTO `messages` (`content`, `media`, `from`, `to`, `time`, `readTime`, `chat_id`) VALUES (?, ?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("sssssss", $content, $media, $from, $to, $time, $readTime, $chat_id);
    return $stmt->execute();
  }

  public function readAllMessages()
  {
    $query = "SELECT * FROM `messages`";
    $result = $this->mysqli->query($query);
    if ($result) {
      $data = [];
      while ($row = $result->fetch_assoc()) {
        $data[] = $row;
      }
      return $data;
    } else {
      echo "Error: " . $this->mysqli->error;
      return [];
    }
  }

  public function readAllMessagesWhere($condition)
  {
    $query = "SELECT * FROM `messages` WHERE $condition";
    $result = $this->mysqli->query($query);
    if ($result) {
      $data = [];
      while ($row = $result->fetch_assoc()) {
        $data[] = $row;
      }
      return $data;
    } else {
      echo "Error: " . $this->mysqli->error;
      return [];
    }
  }

  public function readMessage($id)
  {
    $stmt = $this->mysqli->prepare("SELECT * FROM `messages` WHERE id = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    return $result->fetch_assoc();
  }

  public function updateMessage($id, $data)
  {
    $set = implode(", ", array_map(function ($key) {
      return "`$key` = ?";
    }, array_keys($data)));
    $stmt = $this->mysqli->prepare("UPDATE `messages` SET $set WHERE id = ?");
    $types = str_repeat('s', count($data)) . 'i';
    $values = array_values($data);
    $values[] = $id;
    $stmt->bind_param($types, ...$values);
    return $stmt->execute();
  }

  public function deleteMessage($id)
  {
    $stmt = $this->mysqli->prepare("DELETE FROM `messages` WHERE id = ?");
    $stmt->bind_param("i", $id);
    return $stmt->execute();
  }
}
