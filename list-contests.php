<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "project";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Retrieve all contests
$sql = "SELECT id, title FROM contest";
$result = $conn->query($sql);

echo "<h2>All Contests:</h2>";

if ($result->num_rows > 0) {
    echo "<ul>";
    while ($row = $result->fetch_assoc()) {
        echo "<li><a href='view-teams.php?contest_id=" . $row["id"] . "'>Contest ID: " . $row["id"] . " - Title: " . $row["title"] . "</a></li>";
    }
    echo "</ul>";
} else {
    echo "No contests found.";
}

$conn->close();
?>
