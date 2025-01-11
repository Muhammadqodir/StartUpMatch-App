<?php

exit();

require "../config.php";

$mysqli = new mysqli($host, $user, $password, $db);

$mysqli->set_charset("utf8");

// Check connection
if ($mysqli->connect_errno) {
  echo "Failed to connect to MySQL: " . $mysqli->connect_error;
  exit();
}

echo "connected<br>";

function getAllTables($mysqli)
{
  $query = "SELECT table_name FROM information_schema.tables WHERE table_schema = 'alfocusu_startup'";
  $result = $mysqli->query($query);

  if ($result) {
    $tables = [];
    while ($row = $result->fetch_assoc()) {
      $tables[] = $row['table_name'];
    }
    return $tables;
  } else {
    echo "Error: " . $mysqli->error;
    return [];
  }
}

function getTableSchema($mysqli, $table)
{
  $query = "DESCRIBE `$table`";
  $result = $mysqli->query($query);

  if ($result) {
    $schema = [];
    while ($row = $result->fetch_assoc()) {
      $schema[] = $row;
    }
    return $schema;
  } else {
    echo "Error: " . $mysqli->error;
    return [];
  }
}

function generateDBHelper($mysqli, $tables)
{
  echo "Generating DBHelper class...<br>";
  $classContent = "<?php\n\nclass DBHelper {\n  private \$mysqli;\n\n  public function __construct(\$host, \$user, \$password, \$db) {\n    \$this->mysqli = new mysqli(\$host, \$user, \$password, \$db);\n    \$this->mysqli->set_charset(\"utf8\");\n\n    if (\$this->mysqli->connect_errno) {\n      echo \"Failed to connect to MySQL: \" . \$this->mysqli->connect_error;\n      exit();\n    }\n  }\n\n";

  // Add getLastInteredId method
  $classContent .= "  public function getLastInteredId() {\n";
  $classContent .= "    return \$this->mysqli->insert_id;\n";
  $classContent .= "  }\n\n";

  // Add sanitize method
  $classContent .= "  public function sanitize(\$string) {\n";
  $classContent .= "    return \$this->mysqli->real_escape_string(\$string);\n";
  $classContent .= "  }\n\n";

  foreach ($tables as $table) {
    echo $table . "<br>";
    $schema = getTableSchema($mysqli, $table);
    $columns = array_column($schema, 'Field');
    $columnsWithoutId = array_filter($columns, function ($col) {
      return $col !== 'id';
    });
    $params = implode(', ', array_map(function ($col) {
      return '$' . $col;
    }, $columnsWithoutId));
    $dataAssignments = implode("\n      ", array_map(function ($col) {
      return "'$col' => \$$col,";
    }, $columnsWithoutId));

    // Create method
    $classContent .= "  public function create" . ucfirst(rtrim($table, 's')) . "($params) {\n";
    $classContent .= "    \$stmt = \$this->mysqli->prepare(\"INSERT INTO `$table` (`" . implode('`, `', $columnsWithoutId) . "`) VALUES (" . implode(', ', array_fill(0, count($columnsWithoutId), '?')) . ")\");\n";
    $classContent .= "    \$stmt->bind_param(\"" . str_repeat('s', count($columnsWithoutId)) . "\", " . implode(', ', array_map(function ($col) {
      return '$' . $col;
    }, $columnsWithoutId)) . ");\n";
    $classContent .= "    return \$stmt->execute();\n";
    $classContent .= "  }\n\n";

    // Read all method
    $classContent .= "  public function readAll" . ucfirst($table) . "() {\n";
    $classContent .= "    \$query = \"SELECT * FROM `$table`\";\n";
    $classContent .= "    \$result = \$this->mysqli->query(\$query);\n";
    $classContent .= "    if (\$result) {\n";
    $classContent .= "      \$data = [];\n";
    $classContent .= "      while (\$row = \$result->fetch_assoc()) {\n";
    $classContent .= "        \$data[] = \$row;\n";
    $classContent .= "      }\n";
    $classContent .= "      return \$data;\n";
    $classContent .= "    } else {\n";
    $classContent .= "      echo \"Error: \" . \$this->mysqli->error;\n";
    $classContent .= "      return [];\n";
    $classContent .= "    }\n";
    $classContent .= "  }\n\n";

    // Read all with condition method
    $classContent .= "  public function readAll" . ucfirst($table) . "Where(\$condition) {\n";
    $classContent .= "    \$query = \"SELECT * FROM `$table` WHERE \$condition\";\n";
    $classContent .= "    \$result = \$this->mysqli->query(\$query);\n";
    $classContent .= "    if (\$result) {\n";
    $classContent .= "      \$data = [];\n";
    $classContent .= "      while (\$row = \$result->fetch_assoc()) {\n";
    $classContent .= "        \$data[] = \$row;\n";
    $classContent .= "      }\n";
    $classContent .= "      return \$data;\n";
    $classContent .= "    } else {\n";
    $classContent .= "      echo \"Error: \" . \$this->mysqli->error;\n";
    $classContent .= "      return [];\n";
    $classContent .= "    }\n";
    $classContent .= "  }\n\n";

    // Read single method
    $classContent .= "  public function read" . ucfirst(rtrim($table, 's')) . "(\$id) {\n";
    $classContent .= "    \$stmt = \$this->mysqli->prepare(\"SELECT * FROM `$table` WHERE id = ?\");\n";
    $classContent .= "    \$stmt->bind_param(\"i\", \$id);\n";
    $classContent .= "    \$stmt->execute();\n";
    $classContent .= "    \$result = \$stmt->get_result();\n";
    $classContent .= "    return \$result->fetch_assoc();\n";
    $classContent .= "  }\n\n";

    // Update method
    $classContent .= "  public function update" . ucfirst(rtrim($table, 's')) . "(\$id, \$data) {\n";
    $classContent .= "    \$set = implode(\", \", array_map(function(\$key) {\n";
    $classContent .= "      return \"`\$key` = ?\";\n";
    $classContent .= "    }, array_keys(\$data)));\n";
    $classContent .= "    \$stmt = \$this->mysqli->prepare(\"UPDATE `$table` SET \$set WHERE id = ?\");\n";
    $classContent .= "    \$types = str_repeat('s', count(\$data)) . 'i';\n";
    $classContent .= "    \$values = array_values(\$data);\n";
    $classContent .= "    \$values[] = \$id;\n";
    $classContent .= "    \$stmt->bind_param(\$types, ...\$values);\n";
    $classContent .= "    return \$stmt->execute();\n";
    $classContent .= "  }\n\n";

    // Delete method
    $classContent .= "  public function delete" . ucfirst(rtrim($table, 's')) . "(\$id) {\n";
    $classContent .= "    \$stmt = \$this->mysqli->prepare(\"DELETE FROM `$table` WHERE id = ?\");\n";
    $classContent .= "    \$stmt->bind_param(\"i\", \$id);\n";
    $classContent .= "    return \$stmt->execute();\n";
    $classContent .= "  }\n\n";
  }

  $classContent .= "}\n";

  file_put_contents('db_helper.php', $classContent);
}

// Generate DBHelper class
$tables = getAllTables($mysqli);
print_r($tables);
generateDBHelper($mysqli, $tables);

echo "DBHelper class generated successfully.";
