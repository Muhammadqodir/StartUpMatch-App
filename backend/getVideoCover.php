<?php
if (isset($_GET["url"])) {
  $videoUrl = $_GET["url"];

  $outputImage = 'temp/' . generateRandomString() . '.jpg';
  unlink($outputImage);

  // Use ffmpeg to extract the cover image
  $command = "ffmpeg -i " . escapeshellarg($videoUrl) . " -ss 00:00:01.000 -vframes 1 " . escapeshellarg($outputImage);
  exec($command, $output, $return_var);

  if ($return_var === 0) {
    header('Content-Type: image/jpeg');
    readfile($outputImage);
  } else {
    echo "Failed to extract cover image.";
  }
} else {
  echo "No video URL provided.";
}

function generateRandomString($length = 10)
{
  return substr(str_shuffle(str_repeat($x = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ceil($length / strlen($x)))), 1, $length);
}
