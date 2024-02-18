if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
# win32yank.exe
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# set PATH so if includes deno
export DENO_HOME=$HOME/.deno
if [ -d "$DENO_HOME/bin" ] ; then
    PATH="$DENO_HOME/bin:$PATH"
fi

# set PATH so if includes volta
export VOLTA_HOME=$HOME/.volta
if [ -d "$VOLTA_HOME/bin" ] ; then
    PATH="$VOLTA_HOME/bin:$PATH"
fi

# set PATH so if includes go
export GOPATH=$HOME/go
if [ -d "$GOPATH/bin" ] ; then
    PATH="$GOPATH/bin:$PATH"
fi
# set PATH so if inclueds java
JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
export JAVA_HOME
PATH=$PATH:$JAVA_HOME/bin
export PATH

eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

export VIMRC="$HOME/dotfiles/.vimrc"
export INITVIM="$HOME/dotfiles/init.vim"
export OBSIDIAN="$HOME/myself/diary/"
