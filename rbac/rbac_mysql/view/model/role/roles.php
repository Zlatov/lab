<div id="roles" style="height: 400px;"></div>
<script type="text/javascript">
	var nodes = new vis.DataSet([
		<?php foreach ($roles as $role): ?>
		{id: <?= $role['id'] ?>, label: "<?= $role['name'] ?>"},
		<?php endforeach ?>
	]);

	// create an array with edges
	var edges = new vis.DataSet([
		<?php foreach ($edges as $edge): ?>
		{from: <?= $edge['aid'] ?>, to: <?= $edge['did'] ?>, arrows:'to'},
		<?php endforeach ?>
	]);

	// create a network
	var container = document.getElementById('roles');

	// provide the data in the vis format
	var data = {
		nodes: nodes,
		edges: edges
	};
	var options = {

		edges: {
			smooth: {
				type: 'cubicBezier',
				forceDirection: 'vertical',
				roundness: 0.4
			}
		},
		layout: {
			hierarchical: {
				direction: 'UD'
			}
		},
		physics:false				
	};

	// initialize your network!
	var network = new vis.Network(container, data, options);
</script>
