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
    header("Location: list-contest.php?error=invalid_contest_id");
    exit;
}

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Function to fetch player name by player ID
function getPlayerName($conn, $player_id) {
    $stmt = $conn->prepare("SELECT name FROM players WHERE id = ?");
    $stmt->bind_param("i", $player_id);
    $stmt->execute();
    $stmt->bind_result($player_name);
    $stmt->fetch();
    $stmt->close();
    return $player_name;
}

// SQL query to retrieve participants for the specified contest with their runs
$sql = "
    SELECT 
        pt.id AS participant_id,
        pt.participant_name AS participant_name,
        pt.team_id AS team_id,
        t.player1 AS player1_id,
        t.player2 AS player2_id,
        t.player3 AS player3_id
    FROM 
        participants pt
    JOIN 
        teams t ON pt.team_id = t.id
    WHERE
        t.contest_id = ?
";

$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $contest_id);
$stmt->execute();
$result = $stmt->get_result();

echo "<h2>Participants for Contest ID: $contest_id</h2>";
echo "<table border='1'>";
echo "<tr><th>Rank</th><th>Participant ID</th><th>Participant Name</th><th>Team ID</th><th>Player 1 Name</th><th>Player 1 Runs</th><th>Player 2 Name</th><th>Player 2 Runs</th><th>Player 3 Name</th><th>Player 3 Runs</th><th>Total Score</th></tr>";

if ($result->num_rows > 0) {
    $teams = []; // Array to store team data for sorting
    while ($row = $result->fetch_assoc()) {
        $team_data = [
            "participant_id" => $row["participant_id"],
            "participant_name" => $row["participant_name"],
            "team_id" => $row["team_id"],
            "players" => [], // Array to store player names and runs
            "total_score" => 0 // Initialize total score for the team
        ];

        // Loop through each player and fetch their names and runs
        for ($i = 1; $i <= 3; $i++) {
            $player_id_column = "player" . $i . "_id";
            $player_name = getPlayerName($conn, $row[$player_id_column]);
            $team_data["players"][$i] = [
                "name" => $player_name,
                "runs" => 0 // Initialize runs for each player
            ];

            // Fetch runs for the player if available
            $runs_sql = "SELECT runs FROM run WHERE player_id = ? AND contest_id = ?";
            $runs_stmt = $conn->prepare($runs_sql);
            $runs_stmt->bind_param("ii", $row[$player_id_column], $contest_id);
            $runs_stmt->execute();
            $runs_result = $runs_stmt->get_result();

            if ($runs_result->num_rows > 0) {
                $runs_row = $runs_result->fetch_assoc();
                $team_data["players"][$i]["runs"] = $runs_row["runs"];
                $team_data["total_score"] += $runs_row["runs"]; // Add player runs to total score
            }

            $runs_stmt->close();
        }

        // Push team data to the teams array
        $teams[] = $team_data;
    }

    // Sort teams array by total score in descending order
    usort($teams, function($a, $b) {
        return $b["total_score"] - $a["total_score"];
    });

    // Display teams with rank and total score
    $rank = 1;
    foreach ($teams as $team) {
        echo "<tr>";
        echo "<td>" . $rank . "</td>";
        echo "<td>" . $team["participant_id"] . "</td>";
        echo "<td>" . $team["participant_name"] . "</td>";
        echo "<td>" . $team["team_id"] . "</td>";

        // Loop through each player and display their names and runs
        for ($i = 1; $i <= 3; $i++) {
            echo "<td>" . $team["players"][$i]["name"] . "</td>";
            echo "<td>" . $team["players"][$i]["runs"] . "</td>";
        }

        // Display total score for the team
        echo "<td>" . $team["total_score"] . "</td>";

        echo "</tr>";
        $rank++;
    }
} else {
    echo "<tr><td colspan='11'>No participants found for this contest.</td></tr>";
}

echo "</table>";

$stmt->close();
$conn->close();
?>
