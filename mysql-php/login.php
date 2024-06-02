<?php
include 'conn.php';

$email = $_POST['email'];
$password = $_POST['password'];

if (isset($email) && isset($password)) {
    $query = "SELECT * FROM users WHERE email='$email' AND password='$password'";
    $result = $conn->query($query);

    if ($result->num_rows > 0) {
        echo json_encode(["status" => "success", "message" => "Login successful"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Invalid email or password"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Email and Password required"]);
}

$conn->close();
?>
