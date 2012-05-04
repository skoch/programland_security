<?php

	$teams = array(
		"y [it's spanish]" => array(
			"Matt Leiker",
			"Nooka Jones",
			"Luke Browngold",
			"Chris Petrillo",
			"Charlie Montagut",
			"Benjamin Bojko",
			"Able Paris",
			"Stacey Mulcahy",
			"Karina Portuondo",
			"Casey Roeder"
		),
		"Cheapies Playhaus" => array(
			"Lindsay Brady",
			"Danielle Little",
			"Dave Chau",
			"Stephen Koch",
			"Jay Quercia",
			"Georg Fisher",
			"Tatiana Peck",
			"Chris Matthews"
		),
		"Gentle Milk" => array(
			"Mike Kenny",
			"Anis Hoffman",
			"Tyson Damman",
			"Bruce Drummond",
			"Karla Mickens",
			"Josh Kadis",
			"Victor Pineiro",
			"Will Simon"
		),
		"Squid Republic" => array(
			"Laryssa Jardine",
			"Grace Steite",
			"Jason Hart",
			"Jamie Kosoy",
			"Valerie Gnaedig",
			"Nathan Peters",
			"Alec Cumming",
			"Sara Lerner",
			"Nathan Adkisson"
		),
	);


	$mongo  = new Mongo();
	$db = $mongo->big_spaceship;
	$staff_collection = $db->staff;

	foreach ( $teams as $team => $members ) {
		foreach ( $members as $name ) {
			$staff_collection->update(
				array(
					"full_name" => $name
				),
				array( '$set' => array(
						'team' => $team
					)
				)
			);

			// quick test to see if the names match
			// $cursor = $staff_collection->find( array( 'full_name' => $name ) );
			// while( $cursor->hasNext() )
			// {
			// 	$user = $cursor->getNext();
			// 	if ( $user["team"] != $team ) {
			// 		echo "$name was with " . $user["team"] . " and traded to $team\n";
			// 		// update here with above statement instead if you want
			// 	} else {
			// 		echo "$name is staying with $team\n";
			// 	}
			// }
		}
	}
?>
