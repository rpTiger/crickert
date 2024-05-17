<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "project";

// Check if contest_id is provided and valid
if (isset($_GET['contest_id']) && is_numeric($_GET['contest_id'])) {
    $contest_id = intval($_GET['contest_id']);
} else {
    // If contest_id is not provided or invalid, redirect back with error
    header("Location: view-teams.php?error=invalid_contest_id");
    exit;
}

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $team_id = intval($_POST['team_id']);
    $participant_name = trim($_POST['participant_name']);

    // Check if participant name is empty
    if (empty($participant_name)) {
        // Redirect back with error message
        $redirect_url = "view-teams.php?contest_id=" . $contest_id . "&error=empty_participant_name";
        header("Location: $redirect_url");
        exit;
    }

    // Insert participant into the database
    $stmt = $conn->prepare("INSERT INTO participants (team_id, participant_name) VALUES (?, ?)");
    $stmt->bind_param("is", $team_id, $participant_name);
    $stmt->execute();
    $stmt->close();

    // Redirect back to the contest teams view
    $redirect_url = "view-teams.php?contest_id=" . $contest_id;
    header("Location: $redirect_url");
    exit;
}

$conn->close();
?>
