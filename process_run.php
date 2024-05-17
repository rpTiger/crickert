<?php
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "project";

// Check if form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Validate and sanitize input data
    $contest_id = $_POST['contest_id'];
    $player_id = $_POST['player'];
    $runs = $_POST['runs'];

    // Validate contest_id, player_id, and runs (ensure they are not empty and are numeric)

    // Create connection
    $conn = new mysqli($servername, $username, $password, $dbname);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Insert data into run table
    $sql = "INSERT INTO run (contest_id, player_id, runs) VALUES (?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("iii", $contest_id, $player_id, $runs);

    if ($stmt->execute()) {
        // Close database connection
        $stmt->close();
        $conn->close();
        
        // Redirect back to add_run.php after a delay
        echo "<script>
                setTimeout(function() {
                    window.location.href = 'add-run.php?contest_id=$contest_id';
                }, 1000); // Redirect after 1 seconds
              </script>";
        echo "Runs added successfully. Redirecting...";
        exit; // Exit PHP script
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }

    $stmt->close();
    $conn->close();
} else {
    // Redirect back if form is not submitted
    header("Location: list-contest2.php");
    exit;
}
?>
