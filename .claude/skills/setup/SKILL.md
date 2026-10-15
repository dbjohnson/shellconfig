---
name: setup
description: Set up this machine from the shellconfig repo. Analyzes everything under dotfiles/, works out the programs, frameworks, fonts and plugins those files depend on, installs the missing ones with the platform's package manager, links the dotfiles into $HOME with distribute.sh, and verifies the shells and editors start cleanly. Use when asked to set up, bootstrap, or provision a machine, or to install the dependencies implied by the dotfiles.
---

# Setup: install what the dotfiles depend on, then link them

The dotfiles in `dotfiles/` are the source of truth. Don't work from a fixed package list:
read the files every time, because they change and the list would go stale.

## 1. Survey the machine

Find out, in one or two commands:

- OS and distro (`uname -s`, `/etc/os-release`), and whether this is a desktop session or a
  headless/SSH box (`$XDG_SESSION_TYPE`, `$WAYLAND_DISPLAY`, `$DISPLAY`, `$SSH_CONNECTION`).
- Package managers available: `pacman` (plus an AUR helper: `yay`/`paru`), `apt`, `dnf`, `brew`.
- Whether `sudo -n true` works. If it doesn't, ask the user to run `! sudo -v` and try again.
  If sudo still can't run non-interactively, collect every privileged command into one script in
  the scratchpad and ask the user to run it themselves (`! bash <path>`), then carry on.
- The login shell (`getent passwd $USER`).

## 2. Build the dependency inventory

Read every file under `dotfiles/` (use `git ls-files dotfiles`). For each one, list what it
needs to work. Look for:

- **Shell framework and sourced files**: `source`/`.` lines, `$ZSH`, oh-my-zsh themes and
  `plugins=(...)` (each plugin may wrap a command that must exist).
- **Commands named by aliases and functions**: the first word of each alias body and each
  command a function calls (`alias vi="nvim"` means nvim is needed; `fortune|ponysay` needs both).
- **Editor plugin managers and their prerequisites**: lazy.nvim/LazyVim need git, a C compiler,
  `rg`, `fd`, `tree-sitter` CLI, `unzip`, a clipboard tool (`wl-clipboard` on Wayland, `xclip`
  on X11), and a Nerd Font; language extras (e.g. `lang.python`) install LSPs through Mason,
  which needs the language runtime. Vim's `pathogen#infect()` needs pathogen and the bundles it
  references.
- **Config that names a program**: git filters (`git lfs`), `core.excludesfile`, a terminal's
  config dir (`~/.config/ghostty` means Ghostty), `matplotlibrc` backends (Qt5Agg means PyQt5),
  fonts (`font-family = ...`).
- **Language toolchains and version managers**: uv, nvm, mise, bun, pnpm, cargo.
- **Python imports in startup files** (e.g. ipython startup importing pandas/numpy/matplotlib).

Then sort every item into one of these groups:

| Group | Meaning | Default action |
|---|---|---|
| Required | The shell or editor errors or breaks at startup without it | install |
| Used | An alias, function or plugin calls it, but startup still works | install |
| Guarded | Only used behind an existence check (`[ -d ... ] &&`, `command -v ... &&`, `try/except`) | report, don't install |
| Other platform | Only applies to another OS (`darwin*` blocks, `/opt/homebrew`, `networksetup`, `/Applications/...`) | skip |
| Legacy | Config for a tool the other dotfiles have replaced (e.g. `.vimrc` plugins when `vim` is aliased to `nvim`) | report, don't install |
| GUI | Terminal emulators, fonts, Qt backends | install only on a desktop session |

Python packages imported by ipython startup files are Guarded (they sit in a `try`); don't
install them globally. Projects get their own venvs through uv.

## 3. Check what's already present

For each item, check with `command -v`, the package manager (`pacman -Q`, `dpkg -s`,
`brew list`), `fc-list` for fonts, or the directory it lives in (`~/.oh-my-zsh`). Map every
missing item to the package name on this platform and confirm it exists
(`pacman -Si`, `apt-cache policy`, `brew info`). Prefer the distro's own packages over curl
installers. Use a curl installer only when there's no package (oh-my-zsh is the usual case).

## 4. Check for files that linking would replace

`distribute.sh` runs `ln -sfn` for every file under `dotfiles/`, which silently replaces
whatever is at the destination. For each destination, note whether it is missing, already the
right symlink, or an existing file or symlink that would be overwritten. If a whole directory is
managed by something else (e.g. a distro-provided `~/.config/nvim` with its own `init.lua`),
linking a single file into it mixes the two setups. Point that out specifically.

## 5. Present the plan and get one confirmation

Show the user a compact table: item, group, the dotfile that implies it, status
(present/missing), and the package or install command. Below it, list the files that would be
overwritten. Then ask once with AskUserQuestion, offering to:

- install Required + Used (+ GUI on a desktop) and link everything, backing up overwritten files,
- also install the Guarded/Legacy items,
- or install only and skip linking.

Don't start installing before the user answers.

## 6. Install

- Batch system packages into one command per manager (`sudo pacman -S --needed ...`,
  `sudo apt-get install -y ...`, `brew install ...`). Use the AUR helper only for packages that
  aren't in the official repos.
- **oh-my-zsh**: install it after the system packages, because its installer exits early if
  zsh isn't installed yet. Run its installer with `RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL
  https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended`
  so it doesn't replace the repo's `.zshrc` or start a shell.
- If a step fails, report the error and continue with the rest. Don't retry blindly.

## 7. Link the dotfiles

Move each existing file that would be overwritten (not ones that are already the right symlink)
into `~/.dotfiles-backup/<YYYYmmdd-HHMMSS>/`, keeping its path relative to `$HOME`. Then run
`./distribute.sh` from the repo root.

## 8. Authorize SSH keys

The user's public keys live at https://github.com/dbjohnson.keys and are not stored in the
repo. This grants those keys login access to the machine, so include it in the step 5
question as its own option (yes on personal machines; ask on shared or work machines).

- Download to the scratchpad with `curl -fsSL`. Stop if the download fails or comes back
  empty, and never write an empty or partial file into `~/.ssh`.
- Check every line with `ssh-keygen -lf <file>` and show the user the fingerprints.
- `mkdir -p ~/.ssh && chmod 700 ~/.ssh`, then append only the keys whose key data isn't
  already in `~/.ssh/authorized_keys`, and `chmod 600` the file. Never remove existing lines:
  the machine may trust keys that aren't on GitHub.
- Don't turn off sshd password login unless the user asks, and only after they have confirmed
  that key login works.

## 9. Post-install steps

- `git lfs install` if git-lfs was installed. If it warns that the `filter.lfs` lines in
  `.gitconfig` are in an older format, leave them: they still work, and `--force` would write
  through the symlink into the repo's `.gitconfig`.
- Neovim: `nvim --headless "+Lazy! sync" +qa` to install plugins (it can take a minute or two).
- Login shell: if the dotfiles expect zsh and it isn't the login shell, `chsh` needs the user's
  password, so ask them to run `! chsh -s "$(command -v zsh)"`.

## 10. Verify and report

- `zsh -i -c 'echo ok'` (and `bash -l -c 'echo ok'` if `.bash_profile` is linked) should print
  only `ok`. Any `command not found` or `no such file` lines are missing dependencies.
- `nvim --headless "+checkhealth" "+w! <scratchpad>/health.txt" +qa`, then pull out the
  ERROR lines.
- Finish with a short summary: what was installed, what was linked, where backups went, what was
  skipped and why, and anything the user still has to do (chsh, log out and back in, a reboot).
