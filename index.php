<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dynamic Player Input</title>
    <script>
        function addPlayer() {
            const playersDiv = document.getElementById('players');
            const newPlayerDiv = document.createElement('div');
            newPlayerDiv.innerHTML = `<input type="text" name="players[]" placeholder="Enter player name" required>`;
            playersDiv.appendChild(newPlayerDiv);
        }
    </script>
</head>
<body>
    <h2>Dynamic Player Input</h2>
    <form action="process.php" method="post">
        <label for="title">Contest Title:</label>
        <input type="text" id="title" name="title" placeholder="Enter contest title" required><br><br>
        <div id="players">
            <div>
                <input type="text" name="players[]" placeholder="Enter player name" required>
            </div>
        </div>
        <button type="button" onclick="addPlayer()">Add Player</button>
        <br><br>
        <input type="submit" value="Generate Teams">
    </form>
</body>
</html>
