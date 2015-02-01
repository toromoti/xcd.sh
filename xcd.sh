#/bin/sh

xcd_err() {
  echo "xcd: $1" 1>&2
}

xcd_show() {
  local easypath
  local keta

  keta="$(( ${#XCD_Q[@]}-1 ))"
  keta="${#keta}"

  for i in $(seq 0 $((${#XCD_Q[@]}-1)))
  do
    easypath="$(echo "${XCD_Q[$i]}" | sed "s|^$HOME|~|")"
    if [ "$i" = "$XCD_Q_INDEX" ]; then
      printf "* %${keta}d $easypath\n" "$i"
    else
      printf "  %${keta}d $easypath\n" "$i"
    fi
  done
}

xcd_minus() {
  if [ ! "$XCD_Q_INDEX" = "$((${#XCD_Q[@]}-1))" ]; then
    xcd_jump $((XCD_Q_INDEX+1)) "=="
  else
    xcd_err 'no backward'
    return 1
  fi
}

xcd_plus() {
  if [ ! "$XCD_Q_INDEX" = '0' ]; then
    xcd_jump $((XCD_Q_INDEX-1)) "=="
  else
    xcd_err 'no forward'
    return 1
  fi
}

xcd_jump() {
  local i

  if [ "$ZSH_NAME" ]; then
    setopt localoptions ksharrays
  fi

  if [ "$1" ]; then
    if [ "$1" -ge 0 ] && [ "$1" -lt "${#XCD_Q[@]}" ]; then
      if [ "$2" = "==" ]; then
        if builtin cd "${XCD_Q[$1]}" ; then
          XCD_Q_INDEX=$1
        else
          xcd_delhist $1
        fi
      else
        cd "${XCD_Q[$1]}" || xcd_delhist $1
      fi
    else
      xcd_err 'invalid argument'
      return 1
    fi
  else
    xcd_show
  fi
}

xcd_delhist() {
  if [ "$1" -eq "$XCD_Q_INDEX" ]; then
    xcd_err 'cannot remove current index'
    return 1
  fi

  if [ "$1" -lt "$XCD_Q_INDEX" ]; then
    XCD_Q_INDEX=$((XCD_Q_INDEX-1))
  fi

  XCD_Q=( "${XCD_Q[@]:0:$1}" "${XCD_Q[@]:$(($1+1))}" )
}

xcd_savehist() {
  local i
  local front
  local back

  if [ "$ZSH_NAME" ]; then
    setopt localoptions ksharrays
  fi

  front=( "${XCD_Q[@]:0:$XCD_Q_INDEX}" )
  back=( "${XCD_Q[@]:$XCD_Q_INDEX}" )

  for i in $(seq 0 $((${#front[@]}-1)))
  do
    if [ "$1" = "${front[$i]}" ]; then
      front=( "${front[@]:0:$i}" "${front[@]:$((i+1))}" )
      XCD_Q_INDEX=$((XCD_Q_INDEX-1))
      break
    fi
  done

  for i in $(seq 0 $((${#back[@]}-1)))
  do
    if [ "$1" = "${back[$i]}" ]; then
      back=( "${back[@]:0:$i}" "${back[@]:$((i+1))}" )
      break
    fi
  done

  XCD_Q=( "${front[@]}" "$1" "${back[@]}" )
}

xcd_init() {
  local orig

  if type xcd_cd > /dev/null 2>&1 ; then
    return 0
  fi

  if type cd | head -n 1 | command grep -q 'function' ; then
    if [ "$ZSH_NAME" ]; then
      orig="$(typeset -f cd)"
      eval "$(echo 'xcd_cd () {'; echo "$orig" | tail -n +2)"
    else
      orig="$(declare -f cd)"
      eval "$(echo 'xcd_cd ()'; echo "$orig" | tail -n +2)"
    fi
  else
    xcd_cd() {
      builtin cd "$@"
      return $?
    }
  fi

  cd() {
    xcd_cd "$@" && xcd_savehist $(pwd)
  }

  XCD_Q=( "$(pwd)" )
  XCD_Q_INDEX=0
}

= () { xcd_jump "$1"; }
- () { xcd_minus; }
+ () { xcd_plus; }

xcd_init
