<?php 
require_once '../includes/db.php'; // The mysql database connection script

$query="SELECT SUM(PRICE * QUANTITY) as PRICE from shop";
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