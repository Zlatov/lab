<!DOCTYPE html>
<html lang="ru">
    <head>
        <meta charset="utf-8">
        <title>HTML5 - Привет, Мир!</title>
        <style type="text/css">
            article, aside, details, figcaption, figure, footer, header, hgroup, menu, nav, section { display: block; }
        </style>
        
        <script src='https://www.google.com/recaptcha/api.js'></script>
    </head>
    <body>
        <p>Привет, Мир!</p>
        <p><a href="./recaptcha.php">recaptcha.php</a></p>

        <?php
            function getCurlData($url, $opt = [])
            {
                $curl = curl_init();
                curl_setopt($curl, CURLOPT_URL, $url);
                curl_setopt($curl, CURLOPT_POST, 1);
                curl_setopt($curl, CURLOPT_PROXY, 'proxy.newstar.ru:3128');
                // curl_setopt($curl, CURLOPT_POSTFIELDS, "postvar1=value1&postvar2=value2&postvar3=value3");
                curl_setopt($curl, CURLOPT_POSTFIELDS, http_build_query($opt));
                curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
                curl_setopt($curl, CURLOPT_TIMEOUT, 10);
                $curlData = curl_exec($curl);
                if($curlData === false)
                {
                    echo "<pre>";
                    printf('Ошибка curl: %s', curl_error($curl));
                    echo "</pre>";
                }
                curl_close ($curl);
                return $curlData;
            }

            if($_SERVER["REQUEST_METHOD"] == "POST")
            {
                if(!empty($_POST['g-recaptcha-response']))
                {
                    $url = "https://www.google.com/recaptcha/api/siteverify";
                    $opt = [
                        'secret' => '6Ld3wRIUAAAAAIYZLkVTcHCc3se8R-EmecxwZsHa',
                        'response' => $_POST['g-recaptcha-response'],
                        'remoteip' => $_SERVER['REMOTE_ADDR']
                    ];
                    $res = getCurlData($url, $opt);
                    echo "<pre>";
                    var_dump($res);
                    echo "</pre>";
                    $res = json_decode($res, true);
                    echo "<pre>";
                    var_dump($res);
                    echo "</pre>";
                }
                else
                {
                    echo "<pre>";
                    var_dump($_POST['g-recaptcha-response']);
                    echo "</pre>";
                }
            } else {
                echo "<pre>";
                var_dump($_SERVER["REQUEST_METHOD"]);
                echo "</pre>";
            }
        ?>

        <form action="" method="post">
            <input type="submit" name="submitform" value="Войти">
            <div class="g-recaptcha" data-sitekey="6Ld3wRIUAAAAAFVBJxnqJNLBfDcg7dO32LlFbx0A"></div>
        </form>
    </body>
</html>
