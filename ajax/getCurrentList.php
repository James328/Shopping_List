<?php 
require_once '../includes/db.php'; // The mysql database connection script

$user_id = '1';	// manually setting the user ID for now, which also means
						// $active_list is manually set in db, currently == 1

// pulling the active_list
$query="
		SELECT active_list 
		AS active_list 
		FROM user 
		WHERE user_id='$user_id'";
$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

$arr = array();
if($result->num_rows > 0) {
	while($row = $result->fetch_assoc()) {
		$arr[] = $row;	
	}
}

$active_list = $arr[0]['active_list'];

$query="
		SELECT name 
		FROM list 
		WHERE list_id='$active_list'";
$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

$arrr = array();
if($result->num_rows > 0) {
	while($row = $result->fetch_assoc()) {
		$arrr[] = $row;	
	}
}

# JSON-encode the response
echo $json_response = json_encode($arrr[0]); // Set to $arr[0] in order to display JSON price, not sure why this was needed yet
?>