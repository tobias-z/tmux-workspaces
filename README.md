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
- Create custom environment variables for each session or window
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
mkdir 2_run
echo "mvn spring-boot:run" > 2_run/start.sh
echo "echo stopped" > 2_run/stop.sh
```

You could also do something like

```sh
mkdir 3_db
echo 'nvim -c "DBUI"' > 3_db/start.sh
```

making it automatically open in the Dadbod UI window

### Environment variables

Each 'workspace' or 'window' configured inside of your `TW_CONFIG` directory can contain a `.env` which will be read into the session or window when they are started.
This means that you are able to have specific environments for each of your workspaces.

`REMINDER`: These variables are sent to the windows ones started through `export KEY=VALUE`, making them very visible to everyone. So please do not add things you may not want leaked such as database passwords that are not only on your local machine.

Example:

```sh
# In `TW_CONFIG`
echo 'XMLLINT_INDENT="    "' > my-workspace/.env # Will be applied to all windows that workspace
echo "SPECIAL=ENV" > my-workspace/2_run/.env # Will only be applied to the 2_run window
```

The window .env files are run after the session's, so overriding variables can be done in the window's .env file

### Commands

_All commands are executed through `tw COMMAND`_

- `select` (opens fzf on the configured `TW_PATHS` and switches to the choosen workspace)
  - Optionally an extra argument can be supplied to predefine the workspace you want to select `tw select /home/tobiasz/.config/nvim`
- `start/stop` (runs all start or stop scripts in every window defined in your current workspace)
  - Optionally an extra argument can be supplied to only run on a single window `tw stop 2_run`
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

## Contributing

I am by no means a script expert, so expect weird things to be done in the code, but any pr's or issues are appreciated!
