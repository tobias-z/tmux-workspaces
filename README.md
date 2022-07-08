<div align="center">

# Tmux Workspaces

Tmux Workspaces allows for easy management of multiple workspaces. It allows you to define which windows you want for each session.
You are able to create start scripts for each window which will be run when the workspace loads.

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
2. Set the TMUX_WORKSPACES variable which is where you will place all your configuration for workspace windows
3. Go to the `src/actions/select.sh` and change the directories to where you want the select to search

Example:

```sh
# $HOME/.zshrc
export PATH=$HOME/dev/scripts/tmux-workspaces/src:$PATH
export TMUX_WORKSPACES="$HOME/.config/tmux-workspaces
```

## Usage

### Configuring a workspace

1. In the `TMUX_WORKSPACES` directory create a folder which directly corresponds to a workspace name.
   Your workspaces will be named after the folder choosen from the select command.
   If you select a folder called `$HOME/dev/scripts/my-workspace` then your workspace will be `my-workspace`
2. Each directory inside of this directory will correspond to a window which will be created when you start the workspace
3. These directories can optionally contain a `start` and `stop` file which line by line will be executed in their respective tmux window

Example:

```sh
# In `TMUX_WORKSPACES`
mkdir my-workspace
cd my-workspace
mkdir 2_test
echo "echo started" > test/start
echo "echo stopped" > test/stop
```

### Commands
