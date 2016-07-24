<?php 
require_once '../includes/db.php'; // The mysql database connection script

$user_id = '1';	// manually setting the user ID for now, which also means
						// $active_list is manually set in db, currently == 1

if(isset($_GET['listID'])){
	$list_id = $mysqli->real_escape_string($_GET['listID']);
}

	$query="
		UPDATE user 
		SET active_list='$list_id' 
		WHERE user_id='$user_id'";
	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

	$result = $mysqli->affected_rows;

	$json_response = json_encode($result);

?>