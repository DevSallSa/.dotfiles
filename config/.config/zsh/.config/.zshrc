#========================= Environment variable

# Complying to XDG Base Directory specifications for shell settings
export XDG_CACHE_HOME="$HOME"/.cache             # Path to cache
export XDG_CONFIG_HOME="$HOME"/.config           # Path to home config folder
export XDG_DATA_HOME="$HOME"/.local/share        # Path to data files
export XDG_STATE_HOME="$HOME"/.local/state       # Path to state data that persist across multiple applications (logs, history, etc..)
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh               # Path to ZSH config
export ZSH="$XDG_DATA_HOME"/oh-my-zsh            # Path to my oh-my-zsh
export HISTFILE="$XDG_STATE_HOME"/zsh/history    # Path to zsh history

# Path to Java HOME
# TODO: UPDATE this to match SDKMAN
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

# Path to Cabal config
export CABAL_CONFIG="$XDG_CONFIG_HOME"/cabal/config
export CABAL_DIR="$XDG_DATA_HOME"/cabal

# Other path
export DOTFILES="$HOME"/.dotfiles
export WORKSPACES="$HOME"/Workspaces
export GDBHISTFILE="$XDG_CONFIG_HOME"/gdb/.gdb_history
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc"
export WINEPREFIX="$XDG_DATA_HOME"/wine
export NVM_DIR="$XDG_CONFIG_HOME"/nvm
export PNPM_HOME="$XDG_DATA_HOME"/pnpm
export SDKMAN_DIR="$XDG_DATA_HOME"/sdkman
export CUSTOM_SCRIPTS_DIR="$HOME"/.local/Scripts
# export PATH="$PATH":"$XDG_DATA_HOME"/cabal/bin:/opt/bin:"$HOME"/.local/bin:$(find $CUSTOM_SCRIPTS_DIR -type d | tr '\n' ':')
export PATH="$PNPM_HOME":/opt/bin:"$HOME"/.local/bin:"$CUSTOM_SCRIPTS_DIR"/bin:"$PATH"

# Settings
export TERM=xterm-256color # For lightline
export MANPAGER="sh -c 'col -bx | batcat -l man -p'"
export MANROFFOPT="-c"
export LANGUAGE=fr_CA.UTF-8
export LC_ALL=fr_CA.UTF-8
export LANG=fr_CA.UTF-8
export LC_TYPE=fr_CA.UTF-8



# ========================= Load oh-my-zsh configs
#
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="gnzh"
# ZSH_THEME="typewritten"
#
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
#DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git  zsh-syntax-highlighting)
source "$ZSH"/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Configuration pour affichage de logo dans Hyper.is
#
## Override auto-title when static titles are desired ($ title My new title)
#title() { export TITLE_OVERRIDDEN=1; echo -en "\e]0;$*\a"}
## Turn off static titles ($ autotitle)
#autotitle() { export TITLE_OVERRIDDEN=0 }; autotitle
## Condition checking if title is overridden
#overridden() { [[ $TITLE_OVERRIDDEN == 1 ]]; }
## Echo asterisk if git state is dirty
#gitDirty() { [[ $(git status 2> /dev/null | grep -o '\w\+' | tail -n1) != ("clean"|"") ]] && echo "*" }
#
## Show cwd when shell prompts for input.
#tabtitle_precmd() {
#   if overridden; then return; fi
#   pwd=$(pwd) # Store full path as variable
#   cwd=${pwd##*/} # Extract current working dir only
#   print -Pn "\e]0;$cwd$(gitDirty)\a" # Replace with $pwd to show full path
#}
#[[ -z $precmd_functions ]] && precmd_functions=()
#precmd_functions=($precmd_functions tabtitle_precmd)
#
## Prepend command (w/o arguments) to cwd while waiting for command to complete.
#tabtitle_preexec() {
#   if overridden; then return; fi
#   printf "\033]0;%s\a" "${1%% *} | $cwd$(gitDirty)" # Omit construct from $1 to show args
#}
#[[ -z $preexec_functions ]] && preexec_functions=()
#preexec_functions=($preexec_functions tabtitle_preexec)

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# ========================= Load settings
#
# autoload -Uz compinit
# Init zsh completion
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

# Loading aliases
emulate sh -c "source $HOME/.config/aliases"

# For Node Version Manager
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# For Starship Prompt
eval "$(starship init zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/home/devsallsa/.local/share/sdkman"
[[ -s "/home/devsallsa/.local/share/sdkman/bin/sdkman-init.sh" ]] && source "/home/devsallsa/.local/share/sdkman/bin/sdkman-init.sh"


# Load Angular CLI autocompletion.
source <(ng completion script)
