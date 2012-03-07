<?php

	$STATUS_TEXT = array("Free","A Little Workload","Pretty Crazy","Insane","Leave me the fuck alone");

	$header = "";
	$success = false;
	$action = "login";
	if(!empty($_POST["coder"]))
	{
		include("basicMySqlConnect.php");	
		
		if($_POST["action"] == "login")
		{
			$result = mysql_query("SELECT username, password, status FROM coder_status WHERE coder = '$_POST[coder]'");
			if(!$result) $header = "User not found.";
			else
			{
				$data = mysql_fetch_array($result);
				if($data["password"] != $_POST["password"]) $header = "Incorrect password";
				else
				{
					$success = true;
					$action = "update";
				}
			}
		}
		elseif($_POST["action"] == "update")
		{		
			$result = mysql_query("UPDATE coder_status SET status = '$_POST[status]' WHERE coder = '$_POST[coder]'");
			if(!$result)
			{
				$success= false;
				$header = "User Not Found";		
			}
			else
			{
				$success = true;
				$header = "Updated";				
				$action = "update";
				
				$result2 = mysql_query("SELECT status FROM coder_status WHERE coder = '$_POST[coder]'");
				$data = mysql_fetch_array($result2);
			}
		}
	}
	
	if($success)
	{
		$curStatus = $STATUS_TEXT[$data["status"]];
		$optionHTML = "";
		foreach($STATUS_TEXT as $key=>$option)
		{
			$optionHTML.= "<option value='" . $key . "' " . ($key == $data["status"] ? "selected='true'>" : ">") . $option . "</option>\n";
		}


		$eof =
<<<EOF
		<html>
			<head><title>Logged In</title></head>
			<body>
				<font color='red'>$header</font> <br>
				<b>Logged in as: </b> $_POST[coder]<br />
				<b>Current Status: </b> $curStatus
				<form action="editStatus.php" method="POST">
					<input type="hidden" name="action" value="$action">
					<input type="hidden" name="coder" value="$_POST[coder]">
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
					User: <input type="text" name="coder"><br />
					Pass: <input type="password" name="password"><br />						
					<input type="submit">
				</form>
			</body>
		</html>	
EOF;
	}

echo $eof;
?>