<?php 
require_once '../includes/db.php'; // The mysql database connection script

$query="
		SELECT list_id, name, created_at 
		FROM list 
		ORDER BY list_id asc";
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