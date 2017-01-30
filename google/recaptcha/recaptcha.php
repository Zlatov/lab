<?php
    $msg = '';

    function getCurlData($url)
    {
        $curl = curl_init();
        curl_setopt($curl, CURLOPT_URL, $url);
        curl_setopt($curl, CURLOPT_RETURNTRANSFER, 1);
        curl_setopt($curl, CURLOPT_TIMEOUT, 10);
        curl_setopt($curl, CURLOPT_USERAGENT, "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2.16) Gecko/20110319 Firefox/3.6.16");
        $curlData = curl_exec($curl);
        curl_close($curl);
        return $curlData;
    }
?>

<!DOCTYPE html>
<html lang="ru">
    <head>
        <meta charset="utf-8">
        <title>HTML5 - Привет, Мир!</title>
        <style type="text/css">
            article, aside, details, figcaption, figure, footer, header, hgroup, menu, nav, section { display: block; }
        </style>
        
        <script src="https://www.google.com/recaptcha/api.js"></script>
    </head>
    <body>
        <p>Привет, Мир!</p>

    <?php
    if($_SERVER["REQUEST_METHOD"] == "POST")
    {
        $recaptcha = $_POST['g-recaptcha-response'];
        if(!empty($recaptcha))
        {
            include("getCurlData.php");
            $google_url = "https://www.google.com/recaptcha/api/siteverify";
            $secret = '6Ld3wRIUAAAAAIYZLkVTcHCc3se8R-EmecxwZsHa';
            $ip = $_SERVER['REMOTE_ADDR'];
            $url = $google_url."?secret=".$secret."&response=".$recaptcha."&remoteip=".$ip;
            $res = getCurlData($url);
            $res = json_decode($res, true);
            //reCaptcha введена
            if($res['success'])
            {
                $msg = 'ura';
            }
            else
            {
                $msg = "res is false.";
            }

        }
        else
        {
            $msg = "post recaptch is false.";
        }

    }
    ?>

    <form action="" method="post">
        <input type="submit" name="submitform" value="Войти" />
        <p class='msg'><?php echo $msg; ?></p>
        <div class="g-recaptcha" data-sitekey="6Ld3wRIUAAAAAFVBJxnqJNLBfDcg7dO32LlFbx0A"></div>
    </form>
    </body>
</html>
