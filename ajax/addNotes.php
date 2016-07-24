<?php 
require_once '../includes/db.php'; // The mysql database connection script
if(isset($_GET['itemID']))
{
	$item_id = $mysqli->real_escape_string($_GET['itemID']);

	if(isset($_GET['notes'])){
		$notes = $mysqli->real_escape_string($_GET['notes']);
	}

	$query="
		UPDATE item 
		SET notes='$notes' 
		WHERE item_id='$item_id'";

	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);
	$result = $mysqli->affected_rows;

	echo $json_response = json_encode($result);
}
?>