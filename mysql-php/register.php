<?php
header('Content-Type: application/json;charset=UTF-8');
header('Charset: utf-8');
header('Access-Control-Allow-Orgin: *');

$servername = "localhost";
$username = "root";
$password = "";
$dbname = "flutter_auth";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
    http_response_code(500);
    echo json_encode(array('error' => true, 'message' => 'Database connection error'));
    exit;
}

// Process POST data
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST['email'];
    $password = $_POST['password'];

    if (empty($email) || empty($password)) {
        http_response_code(400);
        echo json_encode(array('error' => true, 'message' => 'Missing required fields.'));
        exit;
    }

    // Perform insert query to register user
    $sql = "INSERT INTO users (email, password) VALUES ('$email', '$password')";

    if ($conn->query($sql) === TRUE) {
        // Registration successful
        echo json_encode(array('error' => false, 'message' => 'User registered successfully'));
    } else {
        // Registration failed
        http_response_code(500);
        echo json_encode(array('error' => true, 'message' => 'Error registering user: ' . $conn->error));
    }
} else {
    // Invalid request method
    http_response_code(400);
    echo json_encode(array('error' => true, 'message' => 'Invalid request method'));
}

// Close connection
$conn->close();
?>
