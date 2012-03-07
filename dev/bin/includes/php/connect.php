
<?php
	
	$db_host		= "localhost";
	$db_user		= "root";
	$db_password	= "root";
	$db_db			= "crew";

	$link = mysql_connect($db_host, $db_user, $db_password)
	or die("Could not connect: " . mysql_error());
	mysql_select_db( $db_db ) or die ( "Couldn't open $db_db: ".mysql_error() );
	
?>
