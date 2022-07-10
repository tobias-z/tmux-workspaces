<div align="center">

# Tmux Workspaces

Tmux Workspaces allows for easy management of multiple workspaces. It allows you to define which windows you want for each session.
You are able to create start scripts for each window which will be run when the workspace loads.

_A lot of the selection code has been yoinked from ThePrimeagen as well as some ideas of workflow_

[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

</div>

## Features

- Find workspaces in directories of your choice, using fzf.
- Customizable windows for each workspace.
- Create custom start scripts for each window to run when the workspace is created
- Create custom stop scripts for each window
- Ability to run these scripts through the `tw` command

## Requirements

- tmux
- fzf
- realpath (on a Mac this can be install through `brew install coreutils`)

## Installation

Clone the repository to anywhere in your file system

```sh
git clone https://github.com/tobias-z/tmux-workspaces
chmod +x ./tmux-workspaces/src/tw
```

1. Put the src folder into your PATH so that you can run the tw command
2. Set the TW_CONFIG variable which is where you will place all your configuration for workspace windows
3. Set the TW_PATHS variable to the directories the select to search
4. Set the TW_MAIN_WINDOW variable to what you want your first window to be called (this is done so that you are able to create start and stop scripts for the main window aswell)

Example:

```sh
# $HOME/.zshrc
export PATH=$HOME/dev/scripts/tmux-workspaces/src:$PATH
export TW_CONFIG="$HOME/.config/tw"
export TW_PATHS="$HOME/dev/scripts $HOME/personal $HOME/example"
export TW_MAIN_WINDOW="main"
```

## Usage

### Configuring a workspace

1. In the `TW_CONFIG` directory create a folder which directly corresponds to a workspace name.
   Your workspaces will be named after the folder choosen from the select command.
   If you select a folder called `$HOME/dev/scripts/my-workspace` then your workspace will be `my-workspace`
2. Each directory inside of this directory will correspond to a window which will be created when you start the workspace
3. These directories can optionally contain a `start.sh` and `stop.sh` shell script will be executed in their respective tmux window

Example:

```sh
# In `TW_CONFIG`
mkdir my-workspace
cd my-workspace
mkdir 2_test
echo "echo started" > 2_test/start.sh
echo "echo stopped" > 2_test/stop.sh
```

### Commands

_All commands are executed through `tw COMMAND`_

- `select` (opens fzf on the configured `TW_PATHS` and switches to the choosen workspace)
  - Optionally an extra argument can be supplied to predefine the workspace you want to select `tw select /home/tobiasz/.config/nvim`
- `start/stop` (runs all start or stop scripts in every window defined in your current workspace)
  - Optionally an extra argument can be supplied to only run on a single window `tw stop 2_test`
- `restart` (runs stop first then start)
  - Can also be run on a single window

### Example Tmux Bindings

```tmux
# $HOME/.tmux.conf
bind-key -r f run-shell "tmux neww tw select"
bind-key -r S run-shell "tw restart"
bind-key -r u run-shell "tw select $HOME/"
```

where `tmux neww` is used when running `tw select` and no args, so that it creates a new window for our fzf searching
