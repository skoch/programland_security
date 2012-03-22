<?php
	if( $_POST["action"] == "update" )
	{
		$mongo  = new Mongo();
		$db = $mongo->big_spaceship;
		$staff_collection = $db->staff;

		$project = $_POST['project'];

		if( isset( $_POST['status'] ) )
		{
			$status = $_POST['status'];
			$update_array = array(
					'status' => $status,
					'current_project' => $project
				);
		}else
		{
			$update_array = array( 'current_project' => $project );
		}

		$success = $staff_collection->update(
			array(
				"full_name" => $_POST['name']
			),
			array( '$set' => $update_array )
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
