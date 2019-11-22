# Настройки для Ubuntu 18

* В хроме, в параметрах плагина __Shortkeys (Custom Keyboard Shortcuts)__ нажать кнопку __Save__ для сёрфа по поиску без использования мыши.
* В пакете __Compare Side-By-Side.sublime-package__ (`nautilus /home/iadfeshchm/.config/sublime-text-3/Installed\ Packages/Compare\ Side-By-Side.sublime-package`) удалить горячие клафиши нахрен очистив содержимое файла _Default (Linux).sublime-keymap_ что позволит восстановить поведение стандартного сочетяния клавиши __Alt+n__.
* Установить плагин сублайма вручную https://github.com/aziz/SublimeANSI/issues откатив его версию на коммит `git checkout f7188b9d5991f0ea04bac8f6040c50b4c2c8fd48`.
* Установить сочетяние Win+E на домашнюю папку: Win+A->`параметры`->Устройства->Клавиатура->Запуск приложений->Домашняя папка.
* Установить сочетание Ctrl+Alt+T на `gnome-terminal --window --full-screen`, а лучше `gnome-terminal --window --maximize` (см. справку `gnome-terminal --help-window-options`), удалив стандартное сочетание.
* Установить сочетание Ctrl+Alt+End на `gnome-session-quit --power-off` (см. справку `gnome-session-quit --help`).
* Установить rbenv, см. `ruby/all.html`.
* Настроить проксирование для apt если необходимо, см. настройки в `linux/apt/apt.sh`
* Установить „AlternateTab“ из менеджера приложений.
* Установить „Дополнительные настройки Gnome“ из менеджера приложений или `sudo apt install gnome-tweaks`, установить три рабочих места и комбинации Win+Z/+X/+C.
* Установить sudo apt install dconf-editor.
* Установить „Автозагрузка“ из менеджера приложений.
* Установить „Auto Move Windows“ из менеджера приложений — дополнение в „Доп. настройки GNOME“.
* Установить сочетания клавишь для события Win+A->`параметры`->Устройства->Клавиатура->Перемещение->Переместить на рабочее местов вверх/низ на клавиши <kbd>Super + Page Up/Down</kbd>, не смотря на то что они там уже установлены (кроме этих клавишь там так же назначены Ctrl+Alt+Вниз/Вверх, данная настройка отменит использование этих клавишь).
* Установить `sudo apt-get install imwheel` и запустить? `imwheel` - устранит на 18 убунте баг скрола.
    1. Add following lines to _~/.imwheelrc_ and save
    ```
".*"
    Control_L, Up,   Control_L|Button4
    Control_L, Down, Control_L|Button5
    ```
    2. Add following command to Startup Application Preferences `imwheel --kill --buttons "4 5"`
