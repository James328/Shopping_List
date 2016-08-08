<?php 
require_once '../includes/db.php'; // The mysql database connection script

if(isset($_GET['authID']))
{
	$auth_id = $mysqli->real_escape_string($_GET['authID']);
}

# Pulling the active_list
$query="SELECT active_list FROM user WHERE auth_id='$auth_id'";
$result = $mysqli->query($query) or die($mysqli->error.__LINE__);
$active_list = array();
if($result->num_rows > 0) {
	while($row = $result->fetch_assoc()) {
		$active_list[] = $row;	
	}
}
$active_list = $active_list[0]['active_list'];

if($active_list == '1')
{
	$query="
		SELECT SUM(price * quantity) 
		AS price 
		FROM item";
}
else
{
	$query="
		SELECT SUM(price * quantity) 
		AS price 
		FROM item 
		WHERE list_id='$active_list'";
}
$result = $mysqli->query($query) or die($mysqli->error.__LINE__);


$arr = array();
if($result->num_rows > 0) {
	while($row = $result->fetch_assoc()) {
		$arr[] = $row;	
	}
}

# JSON-encode the response
echo $json_response = json_encode($arr[0]); // Set to $arr[0] in order to display JSON price, not sure why this was needed yet
?>