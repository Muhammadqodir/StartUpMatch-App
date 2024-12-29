<?php
function goToRoute($route)
{
  header('Location: ' . BASE_URL . $route);
}

function goToRouteWithMessage($route, $message)
{
  $_SESSION["message"] = $message;
  header('Location: ' . BASE_URL . $route);
}

function getCurrentRouteUtils()
{
  require "config.php";
  $actual_link = "$_SERVER[REQUEST_URI]";
  return str_replace($base_url, "", (empty($_SERVER['HTTPS']) ? 'http' : 'https') . "://$_SERVER[HTTP_HOST]" . parse_url($actual_link, PHP_URL_PATH));
}


function goBack()
{
  header('Location: ' . parse_url($_SERVER['HTTP_REFERER'], PHP_URL_PATH));
}

function goBackWithMessage($message)
{
  $_SESSION["message"] = $message;
  header('Location: ' . parse_url($_SERVER['HTTP_REFERER'], PHP_URL_PATH));
}

function getCurrentRoute()
{
  $actual_link = "$_SERVER[REQUEST_URI]";
  return str_replace(BASE_URL, "", (empty($_SERVER['HTTPS']) ? 'http' : 'https') . "://$_SERVER[HTTP_HOST]" . parse_url($actual_link, PHP_URL_PATH));
}

function getRoute($route)
{
  return BASE_URL . $route;
}
