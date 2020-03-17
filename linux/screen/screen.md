# screen

## Использование

* `screen -ls` — список скринов;
* `screen -r` — список скринов или если он один сразу зайти в него;
* `screen -r 2398` — зайти в скрин с заданным идентификатором;
* `screen -S foo` — создать скрин с алиасом;
* `screen -r foo` — зайти в скрин с заданным алиасом;
* `screen -S 2398 -X quit` — kill screen session;
* `screen -wipe` — remove dead screens with.

## Горячие клавиши

* _Ctrl_ + _a_, _d_ — выйти из скрина
* _Ctrl_ + _a_; _Esc_ — перейти в режим прокрутки/копирования
* _Enter_ ; _Enter_ — выйти из режима прокрутки/копирования
* _Space_ — команда помечающая начало и конец копируемого фрагмента в режиме копирования
* _c_ — команда переключающая в блочный режим выделения (после начала выделения по _Space_)
* _Ctrl_ + _a_; _]_ — вставка скопированного текста после выхода из режима прокрутки/копирования

|Key|Action|Notes
|---|---|---
Ctrl+a c|new window| 
Ctrl+a n|next window|I bind F12 to this
Ctrl+a p|previous window|I bind F11 to this
Ctrl+a "|select window from list|I have window list in the status line
Ctrl+a Ctrl+a|previous window viewed| 
||
Ctrl+a S|split terminal horizontally into regions|Ctrl+a c to create new window there
Ctrl+a \||split terminal vertically into regions|Requires screen >= 4.1
Ctrl+a :resize|resize region| 
Ctrl+a :fit|fit screen size to new terminal size|Ctrl+a F is the same. Do after resizing xterm
Ctrl+a :remove|remove region|Ctrl+a X is the same
Ctrl+a tab|Move to next region| 
||
Ctrl+a d|detach screen from terminal|Start screen with -r option to reattach
Ctrl+a A|set window title| 
Ctrl+a x|lock session|Enter user password to unlock
Ctrl+a [|enter scrollback/copy mode|Enter to start and end copy region. Ctrl+a ] to leave this mode
Ctrl+a ]|paste buffer|Supports pasting between windows
Ctrl+a >|write paste buffer to file|useful for copying between screens
Ctrl+a <|read paste buffer from file|useful for pasting between screens
||
Ctrl+a ?|show key bindings/command names|Note unbound commands only in man page
Ctrl+a :|goto screen command prompt|up shows last command entered
