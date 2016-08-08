<?php 
require_once '../includes/db.php'; // The mysql database connection script

$status 	= '%';

if(isset($_GET['userID']))
{
	$user_id = $mysqli->real_escape_string($_GET['userID']);
}

if(isset($_GET['status']))
{
	$status = $mysqli->real_escape_string($_GET['status']);
}

//Debug
//echo 'Auth id: ' . $user_id . '<br />';

# Pulling the active_list
$query="SELECT active_list FROM user WHERE auth_id='$user_id'";

$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

$active_list = array();
if($result->num_rows > 0) {
	while($row = $result->fetch_assoc()) {
		$active_list[] = $row;	
	}
}
$active_list = $active_list[0]['active_list'];

//Debug
//echo 'Active list: ' . $active_list . '<br />'; 
if($active_list == '1')
{
	# If the active list == 1, that means Show All, so we need to query every item in the db..
	$query="
		SELECT item_id, list_id, i.user_id, name, i.created_at, status, quantity, price, notes
		FROM item AS i INNER JOIN user as u
		WHERE i.user_id = '$user_id'
		ORDER BY status,item_id desc, quantity asc";
}
else
{
	# ..else, we query only the items that are in the active list
	$query="
		SELECT item_id, list_id, i.user_id, name, i.created_at, status, quantity, price, notes
		FROM item AS i INNER JOIN user as u
		ON i.list_id = '$active_list'
		WHERE i.user_id = '$user_id'
		ORDER BY status,item_id desc, quantity asc";
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