<?php 
require_once '../includes/db.php'; // The mysql database connection script
if(isset($_GET['name']))
{
	$name = $mysqli->real_escape_string($_GET['name']);
	$status = "0";
	$created = date("Y-m-d", strtotime("now"));

	$quantity ="1";
	if(isset($_GET['quantity'])){
		$quantity = $mysqli->real_escape_string($_GET['quantity']);
	}
	if($quantity == undefined){ $quantity = "1"; } // Make sure $quantity is > 0

	$query="
		INSERT INTO item(name,status,created_at,quantity)
		VALUES ('$name', '$status', '$created', '$quantity')";

	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

	$result = $mysqli->affected_rows;

	echo $json_response = json_encode($result);
}
?>