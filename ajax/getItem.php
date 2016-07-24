<?php 
require_once '../includes/db.php'; // The mysql database connection script
$status = '%';
if(isset($_GET['status']))
{
	$status = $mysqli->real_escape_string($_GET['status']);
}

$user_id = '1';	// manually setting the user ID for now, which also means
						// $active_list is manually set in db, currently == 1

// pulling the active_list
$query="
		SELECT ID, ACTIVE_LIST 
		AS active_list 
		FROM user 
		WHERE id='$user_id'";
$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

$arr = array();
if($result->num_rows > 0) {
	while($row = $result->fetch_assoc()) {
		$arr[] = $row;	
	}
}

$active_list = $arr[0]['active_list'];

if($active_list == '1')
{
	$query="
		SELECT item_id, list_id, user_id, name, created_at, status, quantity, price, notes 
		FROM item 
		ORDER BY status,item_id desc, quantity asc";
}
else
{
	$query="
		SELECT item_id, list_id, user_id, name, created_at, status, quantity, price, notes 
		FROM item 
		WHERE list_id='$active_list' 
		ORDER BY status,item_id desc, quantity asc";
}

//$query="SELECT ID, ITEM, STATUS, CREATED_AT, QUANTITY, PRICE, LIST_ID, NOTES from item where status like '$status' order by status,id desc, quantity asc";

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