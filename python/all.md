# Python

## Установка

### Установка ___python___ — системная версия

```bash
sudo apt-get update
sudo apt-get install python3.6
```

### Установка ___python___ с помощью ___pyenv___

#### Установка ___pyenv___

Установка _pyenv_ зависимостей:

```bash
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev \
libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev python-openssl
```

Инициализация _pyenv_ в _~/.bashrc_:

```bash
export PATH="$HOME/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

#### Использование ___pyenv___

```bash
pyenv install --list # Возможные версии для установки
pyenv install -v 3.7.2 # Установка необходимых версии в стэк версий
pyenv versions # Вывод установленных в стэк версий с указанием текущей в данной директории
python -V # …
which python # …
pyenv which python # более точное место если питон установлен с помощью pyenv
pyenv global 2.7.15 # …
pyenv local 2.7.15 # …
```

## Разобрать

```python
#
import sublime, sublime_plugin, pprint, subprocess, random

class EventListener(sublime_plugin.EventListener):
	def on_activated_async(self, view):
		# print('[listener] pre save event', self.view.id(), view.file_name())
		random.seed()
		rand = random.randint(0, 9999)
		pprint.pprint(rand)
		s = "999"
		status = ""
		output = ""
		status = subprocess.call("~/.config/sublime-text-3/Packages/Prefixw/prefixw.sh", shell=True)
		# status = subprocess.call("./prefixw.sh")
		output = subprocess.check_output("pwd")
		pprint.pprint(status)
		pprint.pprint(output)

class ExampCommand(sublime_plugin.TextCommand):
	def run(self, edit):
		s = 'Hello, world.'
		pprint.pprint(s)
		# print s
		# sublime_plugin.TextCommand.view.insert(edit, 0, "#Hello, World!\n")

class ExampleCommand(sublime_plugin.TextCommand):
	def run(self, edit):
		self.view.insert(edit, 0, "Hello, World!")
		self.view.run_command('examp')
```

```python
import sublime, sublime_plugin, pprint, subprocess

class EventListener(sublime_plugin.EventListener):
	def on_activated_async(self, view):
		output = subprocess.check_output("~/.config/sublime-text-3/Packages/Prefixw/prefixw.sh", shell=True)
		output = output.decode("utf-8").rstrip('\n')
		vtype = type(output)
		pprint.pprint(vtype)
		if output!='done':
			pprint.pprint(output)
```
