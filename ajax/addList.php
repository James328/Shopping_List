<?php 
require_once '../includes/db.php'; // The mysql database connection script
if(isset($_GET['list']))
{
	$list = $mysqli->real_escape_string($_GET['list']);
	$status = "0";
	$created = date("Y-m-d", strtotime("now"));

	$query="INSERT INTO list(name,created_at,status)  VALUES ('$list', '$created', '$status')";

	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);
	$result = $mysqli->affected_rows;

	echo $json_response = json_encode($result);
}
?>