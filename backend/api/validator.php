<?php

function validate($fields, $data)
{
  foreach ($fields as $field) {
    if (!key_exists($field["name"], $data)) {
      return [
        "code" => "400",
        "message" => "Field '" . $field["name"] . "' is required",
        "data" => null
      ];
    }
    switch ($field["type"]) {
      case "string":
        if ($data[$field["name"]] == "") {
          return [
            "code" => "400",
            "message" => "Field '" . $field["name"] . "' must string",
            "data" => null
          ];
        }
        break;
      case "int":
        if (!ctype_digit($data[$field["name"]])) {
          return [
            "code" => "400",
            "message" => "Field '" . $field["name"] . "' must integer",
            "data" => null
          ];
        }
        break;
    }
  }
  return "success";
}

function validationField($name, $type)
{
  return [
    "type" => $type,
    "args" => [],
    "name" => $name,
  ];
}
