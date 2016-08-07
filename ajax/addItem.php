<?php 
require_once '../includes/db.php'; // The mysql database connection script

if(isset($_GET['name']) && isset($_GET['userID']))
{
	$name = $mysqli->real_escape_string($_GET['name']);
	$user_id = $mysqli->real_escape_string($_GET['userID']);
	$status = "0";
	$created = date("Y-m-d", strtotime("now"));

	$quantity ="1";
	if(isset($_GET['quantity'])){
		$quantity = $mysqli->real_escape_string($_GET['quantity']);
	}
	if($quantity == undefined){ $quantity = "1"; } // Make sure $quantity is > 0

	# Pulling the active_list
	$query="SELECT active_list FROM user WHERE user_id='$user_id'";

	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

	$arr = array();
	if($result->num_rows > 0) {
		while($row = $result->fetch_assoc()) {
			$arr[] = $row;	
		}
	}

	$active_list = $arr[0]['active_list'];

	$query="
		INSERT INTO item(list_id,user_id,name,status,created_at,quantity)
		VALUES ('$active_list', '$user_id', '$name', '$status', '$created', '$quantity')";

	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

	$result = $mysqli->affected_rows;

	echo $json_response = json_encode($result);
}
?>