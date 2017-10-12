<div id="roles" style="height: 600px; border: solid 1px black;"></div>
<div id="roles_info">
    <form>
        <fieldset>
            <legend>Роль <span></span></legend>
            Пользователи роли.<br>
            Права роли.<br>
            Права назначенные роли.
        </fieldset>
    </form>
</div>
<script type="text/javascript">
    $('#roles_info').hide()
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
    roles.on('click', function(params) {
        console.log('> click')
        console.log('params: ', params)
        if (params.nodes.length) {
            $('#roles_info').slideDown()
        }
        // params.event = '[original event]';
        // document.getElementById('eventSpan').innerHTML = '<h2>Click event:</h2>' + JSON.stringify(params, null, 4);
        // console.log('click event, getNodeAt returns: ' + this.getNodeAt(params.pointer.DOM));
    });
    roles.on('deselectNode', function(params) {
        console.log('> deselectNode')
        console.log('params: ', params)
        if (!params.nodes.length) {
            $('#roles_info').slideUp()
        }
        // params.event = "[original event]";
        // document.getElementById('eventSpan').innerHTML = '<h2>Click event:</h2>' + JSON.stringify(params, null, 4);
        // console.log('click event, getNodeAt returns: ' + this.getNodeAt(params.pointer.DOM));
    });
</script>
