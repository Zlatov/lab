<div id="roles" style="height: 600px; border: solid 1px black;"></div>
<script type="text/javascript">
	var nodes = new vis.DataSet([
		<?php foreach ($roles as $role): ?>
		{id: <?= $role['id'] ?>, label: ("<?= $role['name'] ?>".split_with_line_breaks(20))},
		<?php endforeach ?>
	]);
	var edges = new vis.DataSet([
		<?php foreach ($edges as $edge): ?>
		{from: <?= $edge['aid'] ?>, to: <?= $edge['did'] ?>, arrows:'to'},
		<?php endforeach ?>
	]);
	var container = document.getElementById('roles');
	var data = {
		nodes: nodes,
		edges: edges
	};
	var options = {
	  nodes: {
	    font: {
	      size: 16
	    },
	    scaling: {
	      max: 160
	    },
	    shape: "box",
	    size: 50
	  },
	  edges: {
	    smooth: false
	  },
	  layout: {
	    hierarchical: {
	      enabled: true,
	      levelSeparation: 100,
	      nodeSpacing: 250,
	      blockShifting: false,
	      edgeMinimization: false,
	      parentCentralization: false
	    }
	  },
	  physics: {
	    enabled: false
	  }
	}
	var roles = new vis.Network(container, data, options);
</script>
