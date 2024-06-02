<?php
include 'conn.php';

$id=$_POST['id'];
$email=$_POST['email'];
$password=$_POST['password'];

$conn->query("update users set email='".$email."', password='".$password."' where id='".$id."'");

?>