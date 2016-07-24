<?php 
require_once '../includes/db.php'; // The mysql database connection script
if(isset($_GET['itemID']))
{
	$itemID = $mysqli->real_escape_string($_GET['itemID']);

	$query="
		UPDATE item 
		SET quantity = quantity+1 
		WHERE id='$itemID' AND quantity >= 0";

	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);
	$result = $mysqli->affected_rows;

	echo $json_response = json_encode($result);
}
?>