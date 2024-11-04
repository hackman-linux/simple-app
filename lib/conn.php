<!--  -->


<?php
// MySQL database connection
$hostname = "localhost";
$username = "codex";
$password = "codex@";
$database = "flutter";

$conn = new mysqli($hostname, $username, $password, $database);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} else {
    echo "Connection established";
}

// Signup function
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $jsonData = json_decode(file_get_contents("php://input"), true);

    if (!isset($jsonData) || empty($jsonData)) {
        http_response_code(400);
        echo json_encode(array("message" => "Invalid request data"));
        exit;
    }

    $username = $jsonData["username"];
    if (isset($jsonData["email"])) {
        $email = $jsonData["email"];
    } else {
        $email = $jsonData["email"] ?? '';
    }
    $password = hash('sha256', $jsonData["password"]);

    if (empty($username) || empty($email) || empty($password)) {
        http_response_code(400);
        echo json_encode(array("message" => "Missing required fields"));
        exit;
    }

    $sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("sss", $username, $email, $password);
    $stmt->execute();

    if ($stmt->affected_rows === TRUE) {
        echo json_encode(array("message" => "Sign up successful"));
    } else {
        echo json_encode(array("message" => "Sign up failed"));
        error_log("Error: " . $stmt->error);
    }
}

// // Login function
// if ($_SERVER["REQUEST_METHOD"] == "POST") {
//     $username = $_POST["username"];
//     $password = $_POST["password"];

//     if (empty($username) || empty($password)) {
//         http_response_code(400);
//         echo json_encode(array("message" => "Missing required fields"));
//         exit;
//     }

//     $sql = "SELECT * FROM users WHERE username = ? AND password = ?";
//     $stmt = $conn->prepare($sql);
//     $stmt->bind_param("ss", $username, $password);
//     $stmt->execute();
//     $result = $stmt->get_result();
//     $user = $result->fetch_assoc();

//     if ($user) {
//         echo json_encode(array("message" => "Login successful"));
//     } else {
//         http_response_code(401);
//         echo json_encode(array("message" => "Invalid credentials"));
//     }
// }

// Login function
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST["username"];
    $password = $_POST["password"];

    if (empty($username) || empty($password)) {
        http_response_code(400);
        echo json_encode(array("message" => "Missing required fields"));
        exit;
    }

    // Hash the password before comparing it with the stored hash
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);

    $sql = "SELECT * FROM users WHERE username = ?";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $username);
    $stmt->execute();
    $result = $stmt->get_result();
    $user = $result->fetch_assoc();

    if ($user) {
        // Verify the password hash
        if (password_verify($password, $user["password"])) {
            echo json_encode(array("message" => "Login successful"));
        } else {
            http_response_code(401);
            echo json_encode(array("message" => "Invalid credentials"));
        }
    } else {
        http_response_code(401);
        echo json_encode(array("message" => "Invalid credentials"));
    }
}

$conn->close();
?>