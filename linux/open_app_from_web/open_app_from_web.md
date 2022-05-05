## 1. Create application launcher script

In a terminal run:

```sh
mkdir -p bin
```

This command will make a bin directory in your home folder if you don't already have it.

After run:

```sh
gedit ~/bin/open_app.sh
```

This will create the new file open_app.sh in gedit.

Copy and paste the following script in the new created file:

```sh
#!/bin/bash

if [[ "$1" != "app://" ]]; then 
    app=${1#app://}
    nohup "$app" &>/dev/null &
else 
    nohup gnome-terminal &>/dev/null &
fi
```

Save the file and close it.

Go back into terminal and run:

```sh
chmod +x ~/bin/open_app.sh
```

to grant execute access for the script.

## 2. Create .desktop file for application launcher

Now you must create a .desktop launcher for the above script, and tell Ubuntu to use this launcher as app:// protocol handler. Create /usr/share/applications/appurl.desktop file using the following command:

```sh
sudo -H gedit /usr/share/applications/appurl.desktop
```

and add the following content:

```sh
[Desktop Entry]
Name=TerminalURL
Exec=/home/radu/bin/open_app.sh %u
Type=Application
NoDisplay=true
Categories=System;
MimeType=x-scheme-handler/app;
```

Save the file and close it.

## 3. Refresh mime types database

In the file above, the line MimeType=x-scheme-handler/app; register app:// scheme handler, but to make it work we should update mime types database cache by executing command:

```sh
sudo update-desktop-database 
```

## 4. Test from terminal

Now everything should work. To test that it works from terminal, run for example this command:

```sh
xdg-open 'app://gedit'
```

## 4. Test from browser using HTML

You can test from browser by using for example the following HTML web page:

```html
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">

<head>
    <title>Open some applications</title>
    <meta http-equiv="content-type" content="text/html;charset=utf-8" />
</head>

<body>
        <h3>Open some applications in Ubuntu from HTML</h3>
        <p>Open terminal: <a title="Open" href="app://">app://</a>
        (equivalent with: <a title="Open" href="app://gnome-terminal">app://gnome-terminal</a>)</p>
        <p>Open Nautilus: <a title="Open" href="app://nautilus">app://nautilus</a></p>
        <p>Open Chromium: <a title="Open" href="app://chromium-browser">app://chromium-browser</a></p>
        <p>Open Ubuntu Software Center: <a title="Open" href="app://software-center">app://software-center</a>
        (equivalent with: <a title="Open" href="apt://">apt://</a>)</p>
        <p>...and so on</p>
</body>

</html>
```
