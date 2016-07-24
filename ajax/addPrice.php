<?php 
require_once '../includes/db.php'; // The mysql database connection script
if(isset($_GET['itemID']) && isset($_GET['price']))
{
	$itemID = $mysqli->real_escape_string($_GET['itemID']);
	$price = $mysqli->real_escape_string($_GET['price']);

	$query="
		UPDATE item 
		SET price='$price' 
		WHERE item_id='$itemID'";

	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);
	$result = $mysqli->affected_rows;

	echo $json_response = json_encode($result);
}
?>