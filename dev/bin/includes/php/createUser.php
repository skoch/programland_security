<?php

	if(!empty($_POST[coder]))
	{
		include("basicMySqlConnect.php");

		$result = mysql_query("INSERT INTO coder_status(coder,username,password,status) VALUES ('$_POST[coder]', '$_POST[username]', '$_POST[password]', '0')");
		if($result) echo "You're in there.";
		else echo "Error.";
	}
	else
	{
		$eof =
<<<EOF
		<html>
			<body>
				<form action="createUser.php" method="POST">
					Your Coder Name: <input type="text" name="coder"> <br />
					Your User Name: <input type="text" name="username"><br />
					Your PW: <input type="password" name="password"><br />
						
					<input type="submit">
				</form>
			</body>
		</html>	
EOF;
		echo $eof;
	}
?>