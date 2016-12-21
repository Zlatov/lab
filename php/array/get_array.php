<a href="?a[]=1&amp;a[as]=2">test</a>
<?php if (isset($_GET['a'])): ?>
    <p>$_GET['a']:</p>
    <?php
    echo "<pre>";
    print_r($_GET['a']);
    echo "</pre>";
    ?>

<?php endif ?>