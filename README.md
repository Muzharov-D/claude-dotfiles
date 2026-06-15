# claude-dotfiles

Пользовательские **агенты, скилы и команды** для [Claude Code](https://claude.com/claude-code) — переносимые между машинами через git.

Всё внутри — обычный markdown, без машинозависимых путей. Работает на macOS / Linux / Windows.

## Что внутри

| | |
|---|---|
| **agents/** | 20 субагентов — `presentation-*`, `time-*`, `weather-*`, `development-workflows-research-agent`, набор `rpi/` (code-reviewer, product-manager, senior-software-engineer, ux-designer, …) и `workflows/best-practice/` |
| **skills/** | 9 скилов — `agent-browser`, `presentation-structure`, `presentation-styling`, `time-*`, `weather-*`, `vibe-to-agentic-framework` |
| **commands/** | 5 слэш-команд — `workflows/best-practice/` |

## Установка (macOS / Linux)

```bash
git clone <URL-этого-репо> ~/claude-dotfiles
cd ~/claude-dotfiles
./install.sh
```

`install.sh` делает симлинки `~/.claude/{agents,skills,commands}` → папки этого репо.
После этого правки в репо сразу видны Claude Code, а `git pull` обновляет конфиг на лету.
Существующие папки (если есть) скрипт не удаляет, а переименует в `*.backup.<дата>`.

## Установка (Windows)

PowerShell (для симлинков нужен **Developer Mode** или запуск от администратора):

```powershell
git clone <URL> $HOME\claude-dotfiles
cd $HOME\claude-dotfiles
.\install.ps1
```

Если симлинки недоступны — скрипт скопирует папки (тогда после правок запускай `install.ps1` снова).

## Плагины (ставятся отдельно)

Сторонние плагины в репо **не входят** (большой размер + своя лицензия). Используемые:

- **gsd** — структурный workflow-плагин (planning / execution / verification).
  Источник: <https://github.com/jnuyens/gsd-plugin>
- **bmad** — BMAD Method, agile AI-driven development (маркетплейс автора PabloLION).

Установка прямо в Claude Code:

```
/plugin marketplace add jnuyens/gsd-plugin
/plugin install gsd@gsd-plugin

/plugin marketplace add <источник-bmad-маркетплейса>
/plugin install bmad@bmad-method
```

> Источник bmad-маркетплейса возьми с машины, где он уже стоит:
> `~/.claude/plugins/known_marketplaces.json`.

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
