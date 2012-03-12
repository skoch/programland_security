<?php 
	if( $_POST["action"] == "update" )
	{
		$mongo  = new Mongo();
		$db = $mongo->big_spaceship;
		$staff_collection = $db->staff;

		$status = $_POST['status'];
		$success = $staff_collection->update(
			array(
				"full_name" => $_POST['name']
			),
			array( '$set' => array(
					'status' => $status
				)	
			)
		);

		if( $success )
		{
			$cursor = $staff_collection->find();
			$returnData = array();
			while( $cursor->hasNext() )
			{
				$returnData[] = $cursor->getNext();
			}

			echo json_encode( array( "success" => $success, "users" => $returnData ) );
		}else
		{
			echo json_encode( array( "success" => $success ) );
		}
	}else
	{
		echo json_encode( array( "success" => false ) );
	}
?>
