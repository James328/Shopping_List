<?php 
require_once '../includes/db.php'; // The mysql database connection script
if(isset($_GET['item']))
{
	$item = $mysqli->real_escape_string($_GET['item']);

	if(isset($_GET['price'])){
		$price = $mysqli->real_escape_string($_GET['price']);
	}

	$query="INSERT INTO shop(item,price)  VALUES ('$item', '$price')";

	$result = $mysqli->query($query) or die($mysqli->error.__LINE__);

	$result = $mysqli->affected_rows;

	echo $json_response = json_encode($result);
}
?>