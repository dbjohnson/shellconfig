shellconfig
===========

linux shell config files

Setup
-----

Run `./setup.sh` on a new machine. It starts Claude Code with the `setup` skill
(`.claude/skills/setup/SKILL.md`), which reads the dotfiles, installs what they
depend on, backs up any files in the way, and links the dotfiles with
`distribute.sh`.
