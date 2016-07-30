<?php 
require_once '../includes/db.php'; // The mysql database connection script

$user_id 	= '1';		// manually setting the user ID for now
$status 	= '%';

if(isset($_GET['status']))
{
	$status = $mysqli->real_escape_string($_GET['status']);
}

# Pulling the active_list
$query="SELECT active_list FROM user WHERE user_id='$user_id'";

$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

$active_list = array();
if($result->num_rows > 0) {
	while($row = $result->fetch_assoc()) {
		$active_list[] = $row;	
	}
}

if($active_list[0]['active_list'] == '1')
{
	# If the active list == 1, that means Show All, so we need to query every item in the db..
	$query="
		SELECT item_id, list_id, i.user_id, name, i.created_at, status, quantity, price, notes
		FROM item AS i INNER JOIN user as u
		WHERE u.user_id = '$user_id'";
}
else
{
	# ..else, we query only the items that are in the active list
	$query="
		SELECT item_id, list_id, i.user_id, name, i.created_at, status, quantity, price, notes
		FROM item AS i INNER JOIN user as u
		ON i.list_id = u.active_list
		WHERE u.user_id = '$user_id'";
}

$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

$arr = array();
if($result->num_rows > 0) {
	while($row = $result->fetch_assoc()) {
		$arr[] = $row;	
	}
}

# JSON-encode the response
echo $json_response = json_encode($arr);
?>