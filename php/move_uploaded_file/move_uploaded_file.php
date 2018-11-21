<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="utf-8">
</head>
<body>
  <form id="form_lorem" action="" method="post" enctype="multipart/form-data">
    <fieldset>
      <legend>Attachments</legend>
      <p>
        <label>
          File
          <input type="file" name="file">
        </label>
      </p>
      <p>
        <label>
          Files
          <input type="file" name="files[]" multiple>
        </label>
      </p>
    </fieldset>
    <p>
      <button type="reset">Reset</button>
      <button type="submit" name="submit" value="submit" class="submit">Submit</button>
    </p>
  </form>
  <?php

    function upload_file($file_info) {
        // echo '$file_info: <pre>';
        // var_export($file_info);
        // echo '</pre>';

        // Путь к папке и её создание
        $folder_path = __DIR__ . DIRECTORY_SEPARATOR . "temp";
        if (!file_exists($folder_path)) {
            mkdir($folder_path);
        }
        // Путь к файлу
        $file_path = $folder_path . DIRECTORY_SEPARATOR . $file_info['name'];

        if (move_uploaded_file($file_info['tmp_name'], $file_path)) {
            echo "<p>Done upload ${file_info['name']}.</p>";
        } else {
            echo "<p>Error upload ${file_info['name']}.</p>";
        }
    }

    if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['submit'])) {
        if (isset($_FILES)) {
            foreach ($_FILES as $key => $value) {
                // echo '$key: <pre>';
                // var_export($key);
                // echo '</pre>';
                // echo '$value: <pre>';
                // var_export($value);
                // echo '</pre>';

                // Файлы могут передаваться по одному:
                // array[
                //  'name' => 'asd',
                //  'error' => 0,
                // ]
                // или по много:
                // array[
                //  'name' => array['asd', 'zxc'],
                //  'error' => [0, 0],
                // ]
                if (is_array($value['error'])) {
                    foreach ($value['error'] as $file_index => $error) {
                        if ($error == 0) {
                            $file_info = [
                              'name' => $value['name'][$file_index],
                              'type' => $value['type'][$file_index],
                              'tmp_name' => $value['tmp_name'][$file_index],
                              'error' => $value['error'][$file_index],
                              'size' => $value['size'][$file_index],
                            ];
                            upload_file($file_info);
                        }
                    }
                } elseif ($value['error'] == 0) {
                    $file_info = $value;
                    upload_file($file_info);
                }
            }
        }
    }

  ?>
</body>
</html>
