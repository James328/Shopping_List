<?php 
require_once '../includes/db.php'; // The mysql database connection script

if(isset($_GET['authID']))
{
	$auth_id = $mysqli->real_escape_string($_GET['authID']);
}
$active_list = 1;
$created = date("Y-m-d", strtotime("now"));

$query="INSERT INTO user(auth_id,active_list,created_at)  VALUES ('$auth_id', '$active_list', '$created')";

$result = $mysqli->query($query) or die($mysqli->error.__LINE__);
$result = $mysqli->affected_rows;

echo $json_response = json_encode($result);
?>