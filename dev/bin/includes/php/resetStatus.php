<?php

	$mongo  = new Mongo();
	$db = $mongo->big_spaceship;
	$staff_collection = $db->staff;

	// $status = $_POST['status'];
	$status = 0;
	$cursor = $staff_collection->find();
	while( $cursor->hasNext() )
	{
		$user = $cursor->getNext();

		$staff_collection->update(
			array(
				"full_name" => $user["full_name"]
			),
			array( '$set' => array(
					'status' => $status
				)
			)
		);
	}

	echo "done resetting all user statuses to: " . $status;

?>