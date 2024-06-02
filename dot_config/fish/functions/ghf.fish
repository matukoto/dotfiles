function ghf
  if set -l d ( ghq list -p | fzf ); and test -n "$d"
    echo "cd $d"
  else
    echo cd ( pwd )
  end
end
