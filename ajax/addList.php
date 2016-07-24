<?php 
require_once '../includes/db.php'; // The mysql database connection script
if(isset($_GET['listName']))
{
	$list_name = $mysqli->real_escape_string($_GET['listName']);
	$status = "0";
	$created = date("Y-m-d", strtotime("now"));

	$query="INSERT INTO list(name,created_at)  VALUES ('$list_name', '$created')";

	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);
	$result = $mysqli->affected_rows;

	echo $json_response = json_encode($result);
}
?>