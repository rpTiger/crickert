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

// Retrieve contest title
$stmt = $conn->prepare("SELECT title FROM contest WHERE id = ?");
$stmt->bind_param("i", $contest_id);
$stmt->execute();
$stmt->bind_result($title);
$stmt->fetch();
$stmt->close();

// Retrieve teams for the specified contest
$stmt = $conn->prepare("SELECT id, team_id, player1, player2, player3 FROM teams WHERE contest_id = ?");
$stmt->bind_param("i", $contest_id);
$stmt->execute();
$result = $stmt->get_result();

echo "<h2>Teams for Contest: $title</h2>";

if ($result->num_rows > 0) {
    while ($row = $result->fetch_assoc()) {
        $team_id = $row["id"];

        // Fetch player names from players table using their IDs
        $player_names = [];
        $player_ids = [$row["player1"], $row["player2"], $row["player3"]];
        foreach ($player_ids as $player_id) {
            $stmt_player = $conn->prepare("SELECT name FROM players WHERE id = ?");
            $stmt_player->bind_param("i", $player_id);
            $stmt_player->execute();
            $stmt_player->bind_result($player_name);
            $stmt_player->fetch();
            $player_names[] = $player_name;
            $stmt_player->close();
        }

        echo "<h3>Team " . $row["team_id"] . ": " . implode(", ", $player_names) . "</h3>";

        // Check if participant already exists for this team
        $stmt_participants = $conn->prepare("SELECT COUNT(*) FROM participants WHERE team_id = ?");
        $stmt_participants->bind_param("i", $team_id);
        $stmt_participants->execute();
        $stmt_participants->bind_result($participant_count);
        $stmt_participants->fetch();
        $stmt_participants->close();

        if ($participant_count >= 1) {
            // Participant already exists for this team, hide input box and add button
            echo "<p>Participant already added for this team.</p>";
        } else {
            // Display form to add participant
            echo "<form action='add-participant.php?contest_id=$contest_id' method='post'>";
            echo "<input type='hidden' name='team_id' value='$team_id'>";
            echo "<input type='text' name='participant_name' placeholder='Enter participant name' required>";
            echo "<input type='submit' value='Add Participant'>";
            echo "</form>";
        }

        // Retrieve participants for this team
        $stmt_participants = $conn->prepare("SELECT id, participant_name FROM participants WHERE team_id = ?");
        $stmt_participants->bind_param("i", $team_id);
        $stmt_participants->execute();
        $participants_result = $stmt_participants->get_result();

        if ($participants_result->num_rows > 0) {
            echo "<ul>";
            while ($participant_row = $participants_result->fetch_assoc()) {
                echo "<li>" . $participant_row["participant_name"] . " (ID: " . $participant_row["id"] . ")</li>";
            }
            echo "</ul>";
        } else {
            echo "No participants added yet.";
        }

        $stmt_participants->close();
    }
} else {
    echo "No teams found for this contest.";
}
$stmt->close();

$conn->close();
?>
