# Настройки для Ubuntu

## Настройки для Ubuntu 18

* Настроить проксирование для apt если необходимо, см. настройки в _linux/apt/apt.sh_
* Установить „Дополнительные настройки Gnome“ из менеджера приложений или `sudo apt install gnome-tweaks` и:
  * Установить смену раскладки клавиатуры в разделе _Клавиатура и мышь_→_дополнительные параметры раскладки_→_переключение на другую раскладку_;
  * <del>, установить три рабочих места и комбинации Win+Z/+X/+C</del>.
* <del>Установить `sudo apt install dconf-editor`</del>.
* В хроме, в параметрах плагина __Shortkeys (Custom Keyboard Shortcuts)__ нажать кнопку __Save__ для сёрфа по поиску без использования мыши.
* <del>В пакете __Compare Side-By-Side.sublime-package__ (`nautilus /home/iadfeshchm/.config/sublime-text-3/Installed\ Packages/Compare\ Side-By-Side.sublime-package`) удалить горячие клафиши нахрен очистив содержимое файла _Default (Linux).sublime-keymap_ что позволит восстановить поведение стандартного сочетяния клавиши __Alt+n__.</del>
* <del>Установить плагин сублайма вручную https://github.com/aziz/SublimeANSI/issues откатив его версию на коммит `git checkout f7188b9d5991f0ea04bac8f6040c50b4c2c8fd48`.</del>
* <del>Установить сочетяние Win+E на домашнюю папку: Win+A->`параметры`->Устройства->Клавиатура->Запуск приложений->Домашняя папка.</del>
* <del>Установить сочетание Ctrl+Alt+T на `gnome-terminal --window --full-screen`, а лучше `gnome-terminal --window --maximize` (см. справку `gnome-terminal --help-window-options`), удалив стандартное сочетание.</del>
* <del>Установить сочетание Ctrl+Alt+End на `gnome-session-quit --power-off` (см. справку `gnome-session-quit --help`).</del>
* 
  ```bash
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ name "Терминал"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ command "gnome-terminal --window --maximize"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/ binding "<Primary><Alt>t"

  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ name "Выключить"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ command "gnome-session-quit --power-off"
  gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/ binding "<Primary><Alt>End"

  gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/', '/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/']"

  gsettings set org.gnome.settings-daemon.plugins.media-keys terminal ""
  gsettings set org.gnome.settings-daemon.plugins.media-keys home "<Super>e"
  ```
* <del>Установить „AlternateTab“ из менеджера приложений.</del>
* 
  ```bash
  gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Super>Tab','<Alt>Tab']"
  gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Super>Tab','<Shift><Alt>Tab']"
  gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>grave']"
  gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>grave']"

  ```
* Установить „Автозагрузка“ из менеджера приложений.
* <del>Установить „Auto Move Windows“ (позволит при автозагрузке открывать приложения в указанных рабочих столах) из менеджера приложений — дополнение в „Доп. настройки GNOME“.</del>
* <del>Установить сочетания клавишь для события Win+A->`параметры`->Устройства->Клавиатура->Перемещение->Переместить на рабочее местов вверх/низ на клавиши <kbd>Super + Page Up/Down</kbd>, не смотря на то что они там уже установлены (кроме этих клавишь там так же назначены Ctrl+Alt+Вниз/Вверх, данная настройка отменит использование этих клавишь).</del>
* 
  ```bash
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-down "['<Super>Page_Down']"
  gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-up "['<Super>Page_Up']"
  ```
* __imwheel__ - устранит на 18 убунте баг скрола. Установить: `sudo apt install imwheel` и настроить:
    1.  `mcedit ~/.imwheelrc` добавить:
        ```
        ".*"
            Control_L, Up,   Control_L|Button4
            Control_L, Down, Control_L|Button5
        ```
    2.  Добавить код в автозагрузку системы: <kbd>Win + A</kbd> → `Автоматически запускаемые приложения`
        или `startup applications`, код: `imwheel --kill --buttons "4 5"`

## Настройки для Ubuntu 20

*   Настройка сочетания клавиш для переключения раскладки клавиатуры:

    ```sh
    sudo apt install gnome-tweaks
    gnome-tweaks
    ```
    *   _Клавиатура и мышь_→_дополнительные параметры раскладки_→_переключение на другую раскладку_

*   Настройка сочетания клавиш для вызова:

    *   Домашней папки Win+E: Win+A->`Настройки`->Комбинации клавиш->Запуск приложений->Домашняя папка.
    *   Терминала Ctrl+Alt+T: Win+A->`Настройки`->Комбинации клавиш->Добавить новую комбинацию (в конце списка). Команда: `gnome-terminal --window --maximize` (см. справку `gnome-terminal --help-window-options`). Удалив стандартное сочетание.
    *   Выключения компьютера Ctrl+Alt+End: Win+A->`Настройки`->Комбинации клавиш->Добавить новую комбинацию (в конце списка). Команда: `gnome-session-quit --power-off` (см. справку `gnome-session-quit --help`).
    *   Многострочного выделения в Sublime Ctrl+Alt+Вверх/Вниз: Win+A->`Настройки`->Комбинации клавиш->Перемещение->Переместить на рабочее местов вверх/низ. Не смотря на то что они там уже установлены!: Сменить на клавиши Win+PageUp/Down - это отменит использование сочетаний Ctrl+Alt+Вниз/Вверх на это же событие и освободит эти сочетания для использования в Sublime.

*   Настроить сочетания клавиш для поиска в google hrome смотри файл _custom_keyboard_shortcuts.md_


## Настройки для Ubuntu 22

***Цензура*** добавили эмодзи на сочетание клавишь <kbd>Ctrl + .</kbd>, из-за этого
не работает комментирование кода (Ctrl+/) в русской раскладке (Ctrl+.)

```sh
# Убираем назначенное сочетание клавишь на эмодзи
gsettings set org.freedesktop.ibus.panel.emoji hotkey "[]"
```

Переключение раскладки правильнее настраивать через gsettings, а не
gnome-tweaks (на переключение теперь реагирует и языковая панель в правом
верхнем углу в трее).

```sh
# Посмотреть какеие сочетания клавишь назначены на "следующая раскладка" и "предыдущая раскладка"
gsettings get org.gnome.desktop.wm.keybindings switch-input-source
gsettings get org.gnome.desktop.wm.keybindings switch-input-source-backward
# Установить Shift+Alt и Alt+Shift соответственно
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "['<Shift>Alt_L']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "['<Alt>Shift_L']"
```
