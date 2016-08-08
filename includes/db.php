<?php 

if ( stristr($_SERVER['SERVER_NAME'], 'localhost' ) )
{
	// dev server
	$heroku_clear_db = false;	// set to false to use local db
}
else
{
	// production server
	$heroku_clear_db = true;	// set to false to use local db
}

if($heroku_clear_db == false)
{
	$DB_HOST = 'localhost';
	$DB_USER = 'root';
	$DB_PASS = 'root';
	$DB_NAME = 'shop';
}
else
{
	//$PATH_TO_SSL_CLIENT_KEY_FILE	=	'/ba703d35c891d1-cert.pem';
	//$PATH_TO_SSL_CLIENT_CERT_FILE	=	'/ba703d35c891d1-key.pem';
	//$PATH_TO_CA_CERT_FILE					= '/cleardb-ca.pem';

	$DB_HOST = 'us-cdbr-iron-east-04.cleardb.net';
	$DB_USER = 'ba703d35c891d1';
	$DB_PASS = '13843980';
	$DB_NAME = 'heroku_21b7ce916a25451';
}

$mysqli = new mysqli($DB_HOST, $DB_USER, $DB_PASS, $DB_NAME);

// Trying to get SSL connection to work
//$db = mysqli_init();
//$db->ssl_set($PATH_TO_SSL_CLIENT_KEY_FILE, $PATH_TO_SSL_CLIENT_CERT_FILE, $PATH_TO_CA_CERT_FILE, null, null);
//$db->real_connect($DB_HOST, $DB_USER, $DB_PASS, $DB_NAME);
?>