# Tide-like layout using only Zsh; Git and language tools are optional.
autoload -Uz add-zsh-hook
zmodload zsh/datetime
typeset -g _dz_git='' _dz_languages='' _dz_mode='' _dz_right=''
typeset -gi _dz_exit=0
typeset -gF _dz_started=0
typeset -gi _dz_apple_developer_tools=1
# Apple's git/python3 stubs may open an installer when developer tools are absent.
if [[ $OSTYPE == darwin* ]] && ! /usr/bin/xcode-select -p >/dev/null 2>&1; then
  _dz_apple_developer_tools=0
fi

# Escape prompt metacharacters and remove terminal control characters from data.
_dz_escape() {
  local value=${1//[[:cntrl:]]/}
  REPLY=${value//\%/%%}
}

_dz_git_info() {
  emulate -L zsh
  _dz_git=''
  (( $+commands[git] )) || return 0
  [[ $commands[git] == /usr/bin/git && $_dz_apple_developer_tools == 0 ]] && return 0
  local output line branch='' gdir operation='' progress='' xy
  local -a fields
  local -i staged=0 dirty=0 untracked=0 conflicted=0 ahead=0 behind=0 stash=0
  output=$(command git --no-optional-locks status --porcelain=v2 --branch --show-stash 2>/dev/null) || return 0
  for line in "${(@f)output}"; do
    case $line in
      '# branch.head '*) branch=${line#\# branch.head } ;;
      '# branch.ab '*)
        fields=( ${(s: :)line} )
        ahead=${fields[3]#+}; behind=${fields[4]#-} ;;
      '# stash '*) stash=${line#\# stash } ;;
      '1 '*|'2 '*)
        fields=( ${(s: :)line} ); xy=$fields[2]
        [[ ${xy[1]} != . ]] && (( staged++ ))
        [[ ${xy[2]} != . ]] && (( dirty++ )) ;;
      'u '*) (( conflicted++ )) ;;
      '? '*) (( untracked++ )) ;;
    esac
  done
  if [[ $branch == '(detached)' ]]; then
    branch=$(command git describe --tags --exact-match 2>/dev/null)
    if [[ -n $branch ]]; then
      branch="#$branch"
    else
      branch="@$(command git rev-parse --short HEAD 2>/dev/null)"
    fi
  fi
  (( ${#branch} > 24 )) && branch="${branch[1,23]}…"
  _dz_escape "$branch"
  _dz_git=" %F{blue} $REPLY%f"
  gdir=$(command git rev-parse --absolute-git-dir 2>/dev/null)
  if [[ -d $gdir/rebase-merge ]]; then
    operation=rebase-m
    [[ -f $gdir/rebase-merge/interactive ]] && operation=rebase-i
    if [[ -r $gdir/rebase-merge/msgnum && -r $gdir/rebase-merge/end ]]; then
      progress=" $(<$gdir/rebase-merge/msgnum)/$(<$gdir/rebase-merge/end)"
    fi
  elif [[ -d $gdir/rebase-apply ]]; then
    operation=am/rebase
    [[ -f $gdir/rebase-apply/rebasing ]] && operation=rebase
    [[ -f $gdir/rebase-apply/applying ]] && operation=am
    if [[ -r $gdir/rebase-apply/next && -r $gdir/rebase-apply/last ]]; then
      progress=" $(<$gdir/rebase-apply/next)/$(<$gdir/rebase-apply/last)"
    fi
  elif [[ -f $gdir/MERGE_HEAD ]]; then
    operation=merge
  elif [[ -f $gdir/CHERRY_PICK_HEAD ]]; then
    operation=cherry-pick
  elif [[ -f $gdir/REVERT_HEAD ]]; then
    operation=revert
  elif [[ -f $gdir/BISECT_LOG ]]; then
    operation=bisect
  fi
  [[ -n $operation ]] && _dz_git+=" %F{red}$operation$progress%f"
  (( behind )) && _dz_git+=" %F{red}󰇘  $behind%f"
  (( ahead )) && _dz_git+=" %F{red}󰇘  $ahead%f"
  (( stash )) && _dz_git+=" %F{white}󰽄 $stash%f"
  (( conflicted )) && _dz_git+=" %F{red} $conflicted%f"
  (( staged )) && _dz_git+=" %F{yellow}󰆼 $staged%f"
  (( dirty )) && _dz_git+=" %F{blue} $dirty%f"
  (( untracked )) && _dz_git+=" %F{green} $untracked%f"
  return 0
}

_dz_version() {
  local color=$1 icon=$2 output
  shift 2
  (( $+commands[$1] )) || return 0
  [[ $commands[$1] == /usr/bin/python3 && $_dz_apple_developer_tools == 0 ]] && return 0
  output=$(command "$@" 2>/dev/null) || return 0
  if [[ $output =~ '[0-9]+(\.[0-9]+)+' ]]; then
    _dz_languages+=" %F{$color}$icon $MATCH%f"
  fi
}

_dz_language_info() {
  emulate -L zsh
  setopt extendedglob nullglob
  _dz_languages=''
  [[ ${DOTFILES_ZSH_LANGUAGE_PROMPT:-1} == 1 ]] || return 0
  local directory=$PWD package='' item output
  local -A detected
  # Inspect filenames/content; never source project files or activate tools.
  while true; do
    for item in "$directory"/*(N) "$directory"/.java-version(N) "$directory"/.lua-version(N); do
      case ${item:t} in
        package.json) detected[node]=1; [[ -z $package ]] && package=$item ;;
        bun.lock|bun.lockb) detected[bun]=1 ;;
        pyproject.toml|requirements.txt|*.py) detected[python]=1 ;;
        Cargo.toml) detected[rust]=1 ;;
        pom.xml|build.gradle|build.gradle.kts|settings.gradle|settings.gradle.kts|*.java|.java-version) detected[java]=1 ;;
        *.csproj) detected[csharp]=1 ;;
        *.fsproj) detected[fsharp]=1 ;;
        *.sln|global.json) detected[csharp]=1; detected[fsharp]=1 ;;
        composer.json|*.php) detected[php]=1 ;;
        Gemfile|*.rb) detected[ruby]=1 ;;
        go.mod) detected[go]=1 ;;
        *.lua|.lua-version) detected[lua]=1 ;;
        build.zig) detected[zig]=1 ;;
        shard.yml) detected[crystal]=1 ;;
        mix.exs) detected[elixir]=1 ;;
        *.tf) detected[terraform]=1 ;;
        Pulumi.yaml|Pulumi.yml) detected[pulumi]=1 ;;
      esac
    done
    [[ $directory == / ]] && break
    directory=${directory:h}
  done
  [[ -n ${detected[bun]-} ]] && _dz_version white '󰳥' bun --version
  [[ -n ${detected[node]-} ]] && _dz_version green '' node --version
  if [[ -n $package && -r $package ]]; then
    output=$(<"$package")
    if [[ $output =~ '"svelte"[[:space:]]*:[[:space:]]*"[~^]?([^" ]+)' ]]; then
      _dz_escape "$match[1]"
      _dz_languages+=" %F{red} $REPLY%f"
    fi
  fi
  [[ -n ${VIRTUAL_ENV-}${detected[python]-} ]] && _dz_version cyan '󰌠' python3 --version
  [[ -n ${detected[rust]-} ]] && _dz_version red '' rustc --version
  if [[ -n ${detected[java]-} && $+commands[java] == 1 ]]; then
    output=''
    if [[ $commands[java] != /usr/bin/java ]] || /usr/libexec/java_home >/dev/null 2>&1; then
      output=$(command java -version 2>&1)
    fi
    if [[ $output =~ '[0-9]+(\.[0-9]+)+' ]]; then
      _dz_languages+=" %F{yellow} $MATCH%f"
    fi
  fi
  [[ -n ${detected[csharp]-} ]] && _dz_version magenta '' dotnet --version
  [[ -n ${detected[fsharp]-} ]] && _dz_version blue '' dotnet --version
  [[ -n ${detected[php]-} ]] && _dz_version blue '' php --version
  [[ -n ${detected[pulumi]-} ]] && _dz_version yellow '' pulumi version
  [[ -n ${detected[ruby]-} ]] && _dz_version red '' ruby --version
  [[ -n ${detected[go]-} ]] && _dz_version cyan '' go version
  [[ -n ${detected[terraform]-} ]] && _dz_version magenta '󱁢' terraform version
  [[ -n ${detected[crystal]-} ]] && _dz_version white '' crystal --version
  [[ -n ${detected[elixir]-} ]] && _dz_version magenta '' elixir --short-version
  [[ -n ${detected[zig]-} ]] && _dz_version yellow '' zig version
  [[ -n ${detected[lua]-} ]] && _dz_version blue '🌙' lua -v
  return 0
}

_dz_render() {
  local color=green location=$PWD
  (( _dz_exit )) && color=red
  if [[ $location == $HOME ]]; then
    location='~'
  elif [[ $location == $HOME/* ]]; then
    location="~/${location#$HOME/}"
  fi
  _dz_escape "$location"
  PROMPT=$'\n'"%F{cyan}%$(( COLUMNS > 40 ? COLUMNS - 20 : 20 ))<…<$REPLY%<<%f$_dz_git"$'\n'"$_dz_mode%F{$color}❯%f "
  RPROMPT=$_dz_right
}

_dz_preexec() { _dz_started=$EPOCHREALTIME; }

_dz_precmd() {
  _dz_exit=$?
  local -i elapsed=0
  (( _dz_started > 0 )) && elapsed=$(( EPOCHREALTIME - _dz_started ))
  _dz_started=0
  _dz_git_info
  _dz_language_info
  _dz_right=''
  (( _dz_exit )) && _dz_right+="%F{red}✘ $_dz_exit%f "
  if (( elapsed >= 3 )); then
    _dz_right+="%F{8} $((elapsed / 60))m $((elapsed % 60))s%f "
  fi
  [[ -n ${SSH_CONNECTION-} || $EUID == 0 ]] && _dz_right+='%F{yellow}%n@%m%f '
  _dz_right+='%(1j.%F{green}%f .)'
  if [[ -n ${AWS_PROFILE-} ]]; then
    _dz_escape "$AWS_PROFILE"
    _dz_right+="%F{yellow} $REPLY%f "
  fi
  if [[ -n ${CLOUDSDK_CORE_PROJECT-} ]]; then
    _dz_escape "$CLOUDSDK_CORE_PROJECT"
    _dz_right+="%F{blue}󰊭 $REPLY%f "
  fi
  _dz_right+="${_dz_languages# } %F{8}%*%f"
  _dz_render
  return 0
}

_dz_keymap() {
  _dz_mode=''
  if [[ -z ${NVIM-} ]]; then
    case ${KEYMAP:-main} in
      vicmd) _dz_mode='%F{white}%f ' ;;
      visual|vivis) _dz_mode='%F{yellow}V%f ' ;;
      *) _dz_mode='%F{cyan}I%f ' ;;
    esac
  fi
  _dz_render
  zle && zle reset-prompt
  return 0
}

autoload -Uz add-zle-hook-widget
add-zsh-hook preexec _dz_preexec
add-zsh-hook precmd _dz_precmd
add-zle-hook-widget line-init _dz_keymap
add-zle-hook-widget keymap-select _dz_keymap
