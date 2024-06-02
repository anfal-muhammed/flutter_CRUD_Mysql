<?php
include 'conn.php';

$email=$_POST['email'];
$password=$_POST['password'];

$conn->query("insert into users(email,password) values('".$email."','".$password."')");

?>