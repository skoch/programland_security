<?php
	
	$mongo  = new Mongo();
	$db = $mongo->big_spaceship;
	$staff_collection = $db->staff;

	if( isset( $_POST['full_name'] ) )
	{
		$user = array(
			"full_name" 	=> $_POST['full_name'],
			"title" 		=> $_POST['title'],
			"email" 		=> $_POST['email'],
			"team" 			=> $_POST['team'],
			"discipline" 	=> $_POST['discipline'],
			"password" 		=> $_POST['password'],
			"status" 		=> $_POST['status']
		);

		if( $staff_collection->insert( $user ) )
		{
			echo "User creation successful.<br>";
		}else
		{
			echo "There was a problem.<br>";
		}
		echo "<a href='createUser.php'>back</a>";

	}else
	{
		$teamsHTML = '';
		$disciplineHTML = '';
		$statusHTML = '';
		$teams = array(
			"Squid Republic",
			"The Special Bears",
			"Cheapies Playhaus",
			"The Stephanies",
			"y [it's spanish]",
			"Milkshake Enterprise",
			"Core"
		);
		foreach( $teams as $key=>$option )
		{
			$teamsHTML .= '<option value="' . $option . '" ' . ($key == 0 ? 'selected="true">' : '>') . $option . '</option>\n';
		}

		$disciplines = array(
			"producers",
			"strategy",
			"technology",
			"designers",
			"core"
		);
		foreach( $disciplines as $key=>$option )
		{
			$disciplineHTML .= "<option value='" . $option . "' " . ($key == 0 ? "selected='true'>" : ">") . $option . "</option>\n";
		}

		$status_text = array(
			"Free",
			"A Little Workload",
			"Pretty Crazy",
			"Insane",
			"Leave this person alone"
		);
		foreach( $status_text as $key=>$option )
		{
			$statusHTML .= "<option value='" . $key . "' " . ($key == 0 ? "selected='true'>" : ">") . $option . "</option>\n";
		}

		$eof =
<<<EOF
		<html>
			<body>
				<form action="createUser.php" method="POST">
					Full Name: <input type="text" name="full_name"> <br>
					Title: <input type="text" name="title"><br>
					Email: <input type="text" name="email"><br>
					Password: <input type="password" name="password"><br>
					Team: <select name="team">
								$teamsHTML
							</select><br>
					Discipline: <select name="discipline">
								$disciplineHTML
							</select><br>
					Status: <select name="status">
								$statusHTML
							</select>
					<input type="submit">
				</form>
			</body>
		</html>	
EOF;
		echo $eof;
	}
?>