<?php
	define( 'IS_DEV', false );
	if( isset( $_GET['b'] ) && $_GET['b'] == '1')
	{
		define( 'BIG_SCREEN', true );
	}else
	{
		define( 'BIG_SCREEN', false );
	}
	define( 'BIG_SCREEN', true );
?>
<!DOCTYPE html>
<html>
	<head>
		<title>Programland Security</title>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
		<link rel="stylesheet" type="text/css" media="screen" href="includes/css/master.css" />
		<?php if( BIG_SCREEN ): ?>
<link rel="stylesheet" type="text/css" media="screen" href="includes/css/big-screen.css" />
		<?php endif; ?>
<link rel='stylesheet' type='text/css' href='http://fonts.googleapis.com/css?family=Doppio+One'>

		<script type="text/javascript" src="includes/js/modernizr.custom.js"></script>
		<script type="text/javascript">

			Modernizr.load({
			// yepnope({
				test: Modernizr.csstransitions,
				nope: [
					'includes/js/jquery.min.js',
					'includes/js/jquery.easing.js'
				],
				load: [
					// 'includes/js/humane.min.js',
					'includes/js/jquery.min.js',
					'includes/js/jquery.isotope.min.js',
					<?php if( IS_DEV ): ?>'includes/js/ProgramlandSecurity.js'
					<?php else: ?>'includes/js/ProgramlandSecurity.min.js'
					<?php endif; ?>

				],
				complete: function()
				{
					ProgramlandSecurity.init( <?= BIG_SCREEN ?> );
				}
			});
		</script>
</head>
<body>
	<div id="container">
		<div id="top-bar">
			<div id="group-name">&nbsp;</div>
			<div id="nav">
				<div class="btn" id="core" data-filter=".core">core</div>
				<div class="btn" id="producers" data-filter=".producers">producers</div>
				<div class="btn" id="engagement" data-filter=".engagement">engagement</div>
				<div class="btn" id="strategy" data-filter=".strategy">strategy</div>
				<div class="btn" id="technology" data-filter=".technology">technology</div>
				<div class="btn" id="designers" data-filter=".designers">designers</div>
				<div class="btn" id="squids" data-filter=".squids">squids</div>
				<div class="btn" id="bears" data-filter=".bears">bears</div>
				<div class="btn" id="cheapies" data-filter=".cheapies">cheapies</div>
				<div class="btn" id="stephanies" data-filter=".stephanies">stephanies</div>
				<div class="btn" id="robots" data-filter=".robots">y</div>
				<div class="btn" id="milkshake" data-filter=".milkshake">milkshake</div>
				<div class="btn" id="o">*</div>
			</div>

		</div>
		<div id="users"></div>
		<footer>
			<input id="search" type="text" value="" />
			<div id="colors">
				<div class="color status-0" id="c-0" data-filter=".status-0"></div>
				<!-- <div class="color status-1" id="c-1" data-filter=".status-1"></div> -->
				<div class="color status-1" id="c-1" data-filter=".status-1"></div>
				<!-- <div class="color status-3" id="c-3" data-filter=".status-3"></div> -->
				<div class="color status-2" id="c-2" data-filter=".status-2"></div>
				<div class="color status-3" id="c-3" data-filter=".status-3"></div>
			</div>
		</footer>

		<div id="change-color">
			<div id="close">x</div>
			<p>&nbsp;</p>
			<input id="working-on" type="text" value="Default" />
			<div class="update-color status-0" id="u-0">Free</div>
			<!-- <div class="update-color status-1" id="u-1">A Little Workload</div> -->
			<div class="update-color status-1" id="u-1">Slightly Busy</div>
			<!-- <div class="update-color status-3" id="u-3">Insane</div> -->
			<div class="update-color status-2" id="u-2">Busy</div>
			<div class="update-color status-3" id="u-3">Out of Office</div>
		</div>
	</div>
</body>
</html>
