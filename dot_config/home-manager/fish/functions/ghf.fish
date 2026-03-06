function ghf
  if set -l d ( ghq list -p | fzf )
    if test -n "$d"
      eval cd $d
    end
  end
end
