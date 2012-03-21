<?php

	// JSON BY DEFAULT
	$returnType = 'json';
	if( isset( $_GET['rt'] ) )
	{
		$returnType = strtolower( $_GET['rt'] );
	}


	$mongo  = new Mongo();
	$db = $mongo->big_spaceship;
	$staff_collection = $db->staff;

	$cursor = $staff_collection->find();

	if( $returnType == 'xml' )
	{
		$s = '<bigspaceship_users>';
		while( $cursor->hasNext() )
		{
			$user = $cursor->getNext();
			$s .= "<user><name>$user[full_name]</name>";
			$s .= "<title>$user[title]</title>";
			$s .= "<discipline>$user[discipline]</discipline>";
			$s .= "<project>$user[current_project]</project>";
			$s .= "<status>$user[status]</status>";
			$s .= "<team>$user[team]</team></user>";

		}
		$s .= '</bigspaceship_users>';

		header("Content-type: application/xml");
		echo $s;
	}else if( $returnType == 'json' )
	{
		$returnData = array();
		while( $cursor->hasNext() )
		{
			$returnData[] = $cursor->getNext();
		}
		echo json_encode( array( 'users' => $returnData ) );
	}


// 	header("Content-type: application/xml");
// 	include("connect.php");

// 	$xml_header =
// <<<EOF
// <xml>
// EOF;

// 	$xml_footer =
// <<<EOF
// </xml>
// EOF;

// 	echo $xml_header;

// 	$result = mysql_query("SELECT * FROM staff_list");
// 	while($data =  mysql_fetch_array($result))
// 	{
// 		$xml =
// <<<EOF
// <user><name>$data[full_name]</name><role>$data[role]</role><affiliations>$data[affiliations]</affiliations><status>$data[status]</status></user>
// EOF;

// 		echo $xml;
// 	}

// echo $xml_footer;

?>