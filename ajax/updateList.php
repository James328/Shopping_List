<?php 
require_once '../includes/db.php'; // The mysql database connection script

$user_id = '1';	// manually setting the user ID for now, which also means
						// $active_list is manually set in db, currently == 1

if(isset($_GET['list'])){
	$list = $mysqli->real_escape_string($_GET['list']);
}

	$query="UPDATE user set active_list='$list' where id='$user_id'";
	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

	$result = $mysqli->affected_rows;

	$json_response = json_encode($result);

?>