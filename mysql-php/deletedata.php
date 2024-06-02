<?php
include 'conn.php';

$id = $_POST['id'];

if (isset($id)) {
    $query = "DELETE FROM users WHERE id='$id'";
    if ($conn->query($query) === TRUE) {
        echo json_encode(["status" => "success", "message" => "Record deleted successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Error deleting record: " . $conn->error]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Invalid ID"]);
}

$conn->close();
?>
