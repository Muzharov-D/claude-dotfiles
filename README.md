# claude-dotfiles

Пользовательские **агенты, скилы и команды** для [Claude Code](https://claude.com/claude-code) — переносимые между машинами через git.

Всё внутри — обычный markdown, без машинозависимых путей. Работает на macOS / Linux / Windows.

## Что внутри

| | |
|---|---|
| **agents/** | 20 субагентов — `presentation-*`, `time-*`, `weather-*`, `development-workflows-research-agent`, набор `rpi/` (code-reviewer, product-manager, senior-software-engineer, ux-designer, …) и `workflows/best-practice/` |
| **skills/** | 9 скилов — `agent-browser`, `presentation-structure`, `presentation-styling`, `time-*`, `weather-*`, `vibe-to-agentic-framework` |
| **commands/** | 5 слэш-команд — `workflows/best-practice/` |

## Быстрая установка на новый Mac (рекомендуется)

Три строки — скрипт сам поставит Claude Code CLI, пропишет PATH и слинкует агенты/скилы/команды:

```bash
git clone https://github.com/Muzharov-D/claude-dotfiles.git ~/claude-dotfiles
cd ~/claude-dotfiles
bash setup-mac.sh
```

Если `git` ещё не установлен — macOS сам предложит поставить Developer Tools, согласись и повтори.
В конце скрипт распечатает 5 команд для плагинов (нужен одноразовый вход через `claude`).

## Установка вручную (только агенты / скилы / команды)

```bash
git clone https://github.com/Muzharov-D/claude-dotfiles.git ~/claude-dotfiles
cd ~/claude-dotfiles
./install.sh
```

`install.sh` делает симлинки `~/.claude/{agents,skills,commands}` → папки этого репо.
После этого правки в репо сразу видны Claude Code, а `git pull` обновляет конфиг на лету.
Существующие папки (если есть) скрипт не удаляет, а переименует в `*.backup.<дата>`.

## Быстрая установка на новый Windows (рекомендуется)

В **PowerShell** (не CMD). Если нет `git` — поставь: `winget install --id Git.Git -e`

```powershell
git clone https://github.com/Muzharov-D/claude-dotfiles.git $HOME\claude-dotfiles
cd $HOME\claude-dotfiles
powershell -ExecutionPolicy Bypass -File .\setup-windows.ps1
```

`setup-windows.ps1` ставит Claude Code CLI и линкует агенты/скилы/команды в `~/.claude`,
а в конце печатает команды для плагинов (нужен одноразовый вход через `claude`).
Для «живых» симлинков включи **Developer Mode** (Параметры → Конфиденциальность и защита → Для разработчиков);
иначе скрипт просто скопирует папки — тогда после `git pull` запускай `install.ps1` снова.

## Установка вручную на Windows (только агенты / скилы / команды)

```powershell
cd $HOME\claude-dotfiles
.\install.ps1
```

## Плагины (ставятся отдельно)

Сторонние плагины в репо **не входят** (большой размер + своя лицензия). Используемые:

- **gsd** — структурный workflow-плагин (planning / execution / verification).
  Источник: <https://github.com/jnuyens/gsd-plugin>
- **bmad** — BMAD Method, agile AI-driven development.
  Источник: <https://github.com/PabloLION/bmad-plugin>

Установка прямо в Claude Code:

```
/plugin marketplace add jnuyens/gsd-plugin
/plugin install gsd@gsd-plugin

/plugin marketplace add PabloLION/bmad-plugin
/plugin install bmad@bmad-method
```

> Команды ставят актуальные версии. На исходной машине стояли bmad `6.2.2.0` и gsd `3.4.10`.

## Что намеренно НЕ включено

- **Память** (`~/.claude/projects/*/memory/`) — личные/рабочие заметки. Держи в приватном репо.
- **MCP-серверы** (`~/.claude.json`) — содержат авторизацию/токены. Переподключи на новой машине.
- Сессии, кэши, телеметрия — локальное состояние, пересоздаётся само.

## Добавить что-то новое

Положи новый агент/скил/команду в соответствующую папку репо (или прямо в `~/.claude/...`,
раз она симлинкнута), затем:

```bash
git add -A && git commit -m "add <что-то>" && git push
```

На другой машине — `git pull`, и всё подхватится.
