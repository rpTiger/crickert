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

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $title = $_POST['title'];
    $players = $_POST['players'];
    
    if (count($players) < 3) {
        echo "You need at least 3 players to form a team.";
        exit;
    }

    // Insert contest into the database
    $stmt = $conn->prepare("INSERT INTO contest (title) VALUES (?)");
    $stmt->bind_param("s", $title);
    $stmt->execute();
    $contest_id = $stmt->insert_id;
    $stmt->close();

    // Insert players into the database
    $player_ids = [];
    $stmt = $conn->prepare("INSERT INTO players (contest_id, name) VALUES (?, ?)");
    foreach ($players as $player) {
        $stmt->bind_param("is", $contest_id, $player);
        $stmt->execute();
        $player_ids[] = $stmt->insert_id; // Store the inserted player IDs
    }
    $stmt->close();

    // Function to generate all possible combinations of players
    function generateTeams($player_ids) {
        $numPlayers = count($player_ids);
        $allTeams = [];

        // Generate all combinations of players
        for ($i = 0; $i < $numPlayers - 2; $i++) {
            for ($j = $i + 1; $j < $numPlayers - 1; $j++) {
                for ($k = $j + 1; $k < $numPlayers; $k++) {
                    $team = [$player_ids[$i], $player_ids[$j], $player_ids[$k]];
                    $allTeams[] = $team;
                }
            }
        }

        return $allTeams;
    }

    // Function to check if a team is valid
    function isValidTeam($team) {
        // Check if all players in the team are distinct
        return count(array_unique($team)) === 3;
    }

    // Generate all possible teams
    $allPossibleTeams = generateTeams($player_ids);

    // Filter valid teams
    $validTeams = array_filter($allPossibleTeams, 'isValidTeam');

    // Shuffle valid teams
    shuffle($validTeams);

    // Insert shuffled teams into the database
    $stmt = $conn->prepare("INSERT INTO teams (contest_id, team_id, player1, player2, player3) VALUES (?, ?, ?, ?, ?)");
    foreach ($validTeams as $teamIndex => $team) {
        $team_id = $teamIndex + 1;
        $stmt->bind_param("iiiii", $contest_id, $team_id, $team[0], $team[1], $team[2]);
        $stmt->execute();
    }
    $stmt->close();

    // Output shuffled teams
    echo "<h2>Shuffled Teams:</h2>";
    foreach ($validTeams as $index => $team) {
        echo "<p>Team " . ($index + 1) . ": " . implode(", ", $team) . "</p>";
    }
}

$conn->close();
?>
