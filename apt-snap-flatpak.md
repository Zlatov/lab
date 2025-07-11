## 🧩 Базовая карта зоопарка пакетных менеджеров

| Название          | Что это                                    | Формат пакетов     | Где берёт пакеты                      | Примеры команд      |
| ----------------- | ------------------------------------------ | ------------------ | ------------------------------------- | ------------------- |
| `apt` / `apt-get` | Менеджер пакетов Debian/Ubuntu             | `.deb`             | Из **репозиториев Ubuntu**            | `apt install curl`  |
| `dpkg`            | Низкоуровневый инструмент установки `.deb` | `.deb`             | **Локальный файл или кэш**            | `dpkg -i файл.deb`  |
| `snap`            | Песоченные пакеты от Canonical             | `.snap`            | Магазин Snap Store                    | `snap install code` |
| `flatpak`         | Альтернатива Snap от сообщества            | `.flatpak`         | Flathub и другие репы                 | `flatpak install`   |
| `gnome-software`  | Графическая оболочка                       | зависит от системы | Может использовать apt, snap, flatpak | —                   |
| `snap-store`      | Графическая оболочка                       | `.snap`            | работает только с Snap                | —                   |

---

## 📦 Что такое `apt`?

* **apt — это консольный пакетный менеджер**, работающий с `.deb` пакетами.
* Он **подключён к списку репозиториев**, обычно из `/etc/apt/sources.list` и `/etc/apt/sources.list.d/*.list`.

Ты качаешь пакеты, например, из:

* [https://archive.ubuntu.com](https://archive.ubuntu.com)
* [https://security.ubuntu.com](https://security.ubuntu.com)

Это **"официальные репозитории Ubuntu"**.

### 🔍 Как посмотреть, что есть в apt?

Открывай:

* 📦 [https://packages.ubuntu.com/](https://packages.ubuntu.com/)
* Или пользуйся командой:

  ```bash
  apt search <имя_пакета>
  ```

---

## 🔐 Репозитории и доверие

apt работает **только с подписанными GPG-ключами**. То есть:

* Когда ты добавляешь сторонний репозиторий (`add-apt-repository` или вручную), ты **добавляешь также публичный GPG-ключ**, чтобы доверять источнику.
* Без него apt не будет качать пакеты (или будет ругаться).

Вот пример добавления стороннего репо:

```bash
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
```

Или вручную:

```bash
echo "deb [signed-by=/usr/share/keyrings/some-key.gpg] https://some.repo stable main" | sudo tee /etc/apt/sources.list.d/some.list
```

---

## 🤔 Чем отличается `dpkg` от `apt`?

* `dpkg` = **низкоуровневый инструмент**. Просто ставит `.deb` файл, который ты скачал.

  ```bash
  sudo dpkg -i ./google-chrome.deb
  ```

* Он **не качает зависимости**, не обновляет систему.

* Если зависимостей не хватает — он просто скажет "ошибка".

* `apt` = **умный уровень**, он:

  * сам подтягивает зависимости
  * работает с репозиториями
  * умеет удалять пакеты, очищать систему и прочее

---

## Snap vs Flatpak vs Apt

| Критерий      | Snap (Canonical)          | Flatpak (сообщество)      | apt (классика)                |
| ------------- | ------------------------- | ------------------------- | ----------------------------- |
| Формат пакета | `.snap`                   | `.flatpak`                | `.deb`                        |
| Изоляция      | Да (sandbox)              | Да (sandbox)              | Нет                           |
| Размер пакета | Большой (всё внутри)      | Тоже немаленький          | Маленький (зависимости общие) |
| Поддержка     | Canonical (Ubuntu)        | RedHat + сообщество       | Debian, Ubuntu                |
| Где хранятся  | `/snap`, `~/snap`         | `~/.var`, `~/.local` и др | `/usr/bin`, `/usr/lib`        |
| Цель          | Универсальный дистрибутив | Альтернатива Snap         | Стандартная система           |

### Почему зоопарк?

* **Snap и Flatpak** появились из желания:

  * делать **универсальные приложения**
  * **не ждать мейнтейнеров Debian/Ubuntu**, чтобы выкатить свежую версию
  * изолировать приложения (sandbox)

---

## ✅ Как действовать на практике?

### Установка системных утилит (curl, git, nginx и пр)

— **используй `apt`**

### Установка софта типа Chrome, VS Code

— **используй `.deb` + `dpkg -i` или `apt install` через официальный репо**

### Snap?

— Иногда может быть полезен, но если не хочешь — **можно отключить snap вообще**.

### Flatpak?

— Пока можешь игнорировать, **если не работаешь с Fedora или Linux Mint**, где он в приоритете.
