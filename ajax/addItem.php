<?php 
require_once '../includes/db.php'; // The mysql database connection script
if(isset($_GET['item']))
{
	$item = $mysqli->real_escape_string($_GET['item']);
	$status = "0";
	$created = date("Y-m-d", strtotime("now"));

	$quantity ="1";
	if(isset($_GET['quantity'])){
		$quantity = $mysqli->real_escape_string($_GET['quantity']);
	}

	$query="INSERT INTO shop(item,status,created_at,quantity)  VALUES ('$item', '$status', '$created', '$quantity')";

	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

	$result = $mysqli->affected_rows;

	echo $json_response = json_encode($result);
}
?>