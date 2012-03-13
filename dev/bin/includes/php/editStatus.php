<?php

	$STATUS_TEXT = array( "Free", "A Little Workload", "Pretty Crazy", "Insane", "Leave Me the Fuck Alone", "Out of Office" );

	$header = "";
	$success = false;
	$action = "login";
	if( ! empty( $_POST["username"] ) )
	{
		$mongo  = new Mongo();
		$db = $mongo->big_spaceship;
		$staff_collection = $db->staff;
		
		if( $_POST["action"] == "login" )
		{
			$cursor = $staff_collection->find( array( 'full_name' => $_POST['username'] ) );
			while( $cursor->hasNext() )
			{
				$user = $cursor->getNext();
				if( $user["password"] != $_POST["password"]) $header = "Incorrect password";
				else
				{
					$success = true;
					$action = "update";
				}
			}
			// if(!$result) $header = "User not found.";
			// else
			// {
			// 	$data = mysql_fetch_array($result);
			// 	if($data["password"] != $_POST["password"]) $header = "Incorrect password";
			// 	else
			// 	{
			// 		$success = true;
			// 		$action = "update";
			// 	}
			// }
		}elseif( $_POST["action"] == "update" )
		{
			$status = $_POST['status'];
			$staff_collection->update(
				array(
					"full_name" => $_POST['username']
				),
				array( '$set' => array(
						'status' => $status
					)	
				)
			);

			$success = true;
			$header = "Updated";				
			$action = "update";

		}
	}
	
	if( $success )
	{
		$curStatus = $STATUS_TEXT[$status];
		$optionHTML = "";
		foreach( $STATUS_TEXT as $key=>$option )
		{
			$optionHTML.= "<option value='" . $key . "' " . ($key == $status ? "selected='true'>" : ">") . $option . "</option>\n";
		}


		$eof =
<<<EOF
		<html>
			<head><title>Logged In</title></head>
			<body>
				<font color='red'>$header</font> <br>
				<b>Logged in as: </b> $_POST[username]<br />
				<b>Current Status: </b> $curStatus
				<form action="editStatus.php" method="POST">
					<input type="hidden" name="action" value="$action">
					<input type="hidden" name="username" value="$_POST[username]">
					<input type="hidden" name="password" value="$_POST[password]">

					Status: <select name="status">
$optionHTML
							</select>					
					<input type="submit">
				</form>
			</body>
		</html>	
EOF;
	}
	else
	{
		$eof =
<<<EOF
		<html>
			<head><title>Sign In</title></head>
			<body>
				<font color='red'>$header</font> <br>
				<form action="editStatus.php" method="POST">
					<input type="hidden" name="action" value="$action">
					User: <input type="text" name="username"><br />
					Pass: <input type="password" name="password"><br />						
					<input type="submit">
				</form>
			</body>
		</html>	
EOF;
	}

echo $eof;
?>