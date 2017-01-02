function ghapi() {
  cmd="curl -i -u gjtorikian:${GITHUB_TOKEN} https://api.github.com$1"
  echo $cmd
  eval $cmd
}

function branch-ghapi() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi

  branch=${ref#refs/heads/}
  sha=`curl https://$branch.branch.github.com/site/sha`
  cmd="curl -u gjtorikian:${GITHUB_TOKEN} --user-agent \"curl/$sha\" -i https://$branch.branch.github.com/api/v3$1"
  echo $cmd
  eval $cmd
}
