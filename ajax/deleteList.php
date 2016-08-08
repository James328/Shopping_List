<?php 
require_once '../includes/db.php'; // The mysql database connection script

if(isset($_GET['authID']))
{
	$auth_id = $mysqli->real_escape_string($_GET['authID']);
}

if(isset($_GET['listID']))
{
	$list_id = $mysqli->real_escape_string($_GET['listID']);

	$query="
		DELETE FROM item 
		WHERE list_id='$list_id'";
	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);
	$result = $mysqli->affected_rows;

	$query="
		UPDATE user 
		SET active_list='1' 
		WHERE auth_id='$auth_id'";
	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);
	$result = $mysqli->affected_rows;

	$query="
		DELETE FROM list 
		WHERE list_id='$list_id'";
	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);
	$result = $mysqli->affected_rows;

	echo $json_response = json_encode($result);
}
?>