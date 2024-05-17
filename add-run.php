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
    header("Location: list_contest.php?error=invalid_contest_id");
    exit;
}

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch players for the specified contest
$sql = "SELECT id, name FROM players WHERE contest_id = $contest_id";
$result = $conn->query($sql);

$conn->close();
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Run</title>
</head>
<body>
    <h2>Add Run for Contest ID: <?php echo $contest_id; ?></h2>

    <form action="process_run.php" method="POST">
        <input type="hidden" name="contest_id" value="<?php echo $contest_id; ?>">

        <label for="player">Select Player:</label>
        <select name="player" id="player">
            <?php
            if ($result->num_rows > 0) {
                while ($row = $result->fetch_assoc()) {
                    echo "<option value='" . $row["id"] . "'>" . $row["name"] . "</option>";
                }
            } else {
                echo "<option value=''>No players found</option>";
            }
            ?>
        </select>

        <label for="runs">Runs:</label>
        <input type="number" name="runs" id="runs" required>

        <input type="submit" value="Add Run">
    </form>
</body>
</html>
