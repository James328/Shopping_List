<?php 
require_once '../includes/db.php'; // The mysql database connection script
if(isset($_GET['listID']))
{
	$list_id = $mysqli->real_escape_string($_GET['listID']);

	$query="
		DELETE FROM list 
		WHERE list_id='$list_id'";
	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

	$result = $mysqli->affected_rows;

	echo $json_response = json_encode($result);
}
?>