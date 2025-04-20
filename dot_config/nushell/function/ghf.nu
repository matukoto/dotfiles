def ghf [] {
  let d = (ghq list -p | fzf | str trim)
  if $d != "" {
    cd $d
  }
}
